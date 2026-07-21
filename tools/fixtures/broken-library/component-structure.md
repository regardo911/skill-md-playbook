# Component structure

- One component per file, named the same as the file
- Props interface declared above the component, exported
- Server components by default. 'use client' only when there is state or an event handler
- Co-locate the component's test and its styles in the same folder
- No barrel index.ts inside component folders, it breaks tree shaking
