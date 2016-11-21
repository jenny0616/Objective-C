---
title: "UITableView"
summary: "create tableview with code"
platform: iOS
completion-scope: Class Implementation
---

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *<#cell#> = [<#tableViewName#> dequeueReusableCellWithIdentifier:<#@"identifier"#>];
    if (<#cell#> == nil) {
        <#cell#> = [UITableViewCell alloc] initWithStyle:<#(UITableViewCellStyle)#> reuseIdentifier:<#(nullable NSString *)#>
    }
    return <#cell#>;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return <#integerValue#>
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return <#integerValue#>
}
