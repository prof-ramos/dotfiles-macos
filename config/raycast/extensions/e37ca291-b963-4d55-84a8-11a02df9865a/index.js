"use strict";var l=Object.defineProperty;var m=Object.getOwnPropertyDescriptor;var f=Object.getOwnPropertyNames;var u=Object.prototype.hasOwnProperty;var h=(o,t)=>{for(var e in t)l(o,e,{get:t[e],enumerable:!0})},F=(o,t,e,i)=>{if(t&&typeof t=="object"||typeof t=="function")for(let n of f(t))!u.call(o,n)&&n!==e&&l(o,n,{get:()=>t[n],enumerable:!(i=m(t,n))||i.enumerable});return o};var y=o=>F(l({},"__esModule",{value:!0}),o);var b={};h(b,{default:()=>$});module.exports=y(b);var a=require("@raycast/api"),c=require("child_process"),w=require("util"),d=require("fs/promises"),s=(0,w.promisify)(c.exec),S=()=>{let o=`
  if application "Finder" is running and frontmost of application "Finder" then
    tell app "Finder"
      set finderWindow to window 1
      set finderWindowPath to (POSIX path of (target of finderWindow as alias))
      return finderWindowPath
    end tell
  else 
    error "Could not get the selected Finder window"
  end if
 `;return new Promise((t,e)=>{let i=(0,c.exec)(`osascript -e '${o}'`,(n,p,r)=>{(n||r)&&e(Error("Could not get the selected Finder window")),t(p.trim())});i.on("close",()=>{i.kill()})})},$=async()=>{let t=(await(0,a.getApplications)()).find(i=>i.bundleId==="com.sublimetext.4");if(!t){await(0,a.showToast)({style:a.Toast.Style.Failure,title:"Sublime Text 4 is not installed",primaryAction:{title:"Install Sublime Text 4",onAction:()=>open("https://www.sublimetext.com/download")}});return}let e=`${t.path}/Contents/SharedSupport/bin/subl`;try{let i=await(0,a.getSelectedFinderItems)();if(i.length){for(let r of i)(await(0,d.stat)(r.path)).isDirectory()?await s(`"${e}" -n "${r.path}"`):await s(`"${e}" -a "${r.path}"`);return}let n=await S();(await(0,d.stat)(n)).isDirectory()?await s(`"${e}" -n "${n}"`):await s(`"${e}" -a "${n}"`);return}catch{await(0,a.showToast)({style:a.Toast.Style.Failure,title:"No Finder items or window selected"})}};
