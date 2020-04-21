Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9B1B2708
	for <lists+linux-api@lfdr.de>; Tue, 21 Apr 2020 15:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgDUNCz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 Apr 2020 09:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728864AbgDUNCy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 Apr 2020 09:02:54 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25D3C061A41
        for <linux-api@vger.kernel.org>; Tue, 21 Apr 2020 06:02:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id q204so11869067oia.13
        for <linux-api@vger.kernel.org>; Tue, 21 Apr 2020 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeatBysOs4g1w9ucJik06kMFsqtbBYNKB2LJi34r5/g=;
        b=ZEHK3zuTVFYNcFuYOAgxTYB5atjiPGX1lleSsfDtvhignUa7fXzs6WpktzR/OAVEGc
         8E1uyGgs3LDOOXc9qAnO0YfOfqcefQ0zM0EsxYkHnrO9Vimg1IYDc6wS9LWjTHf5ERWR
         nL+zBcQ57ReI1KIsOr4yD8DEpcD17YWO2UH3Zuy2GfokaHahgq5LDJ0qoaSrz408loCy
         o34nyylhNIzvvTfjUW1vstzHutbCavTyktxKpSkL1KZuaVaEUwLhEezSih6ycNwuMmie
         RP4kvXAfsYlrZ5pxQahkOhx5t+2D+DWKRNGNiEhW7iAV9LcHogVirvt6RpdWnfvwwrq3
         iJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeatBysOs4g1w9ucJik06kMFsqtbBYNKB2LJi34r5/g=;
        b=a8qiR/YHOYSJGyZ+TIn/muGCsmhwty/U0J/vZsz3Aggj+5cBNFKKn34W/Q44QhLlwg
         qBnJPM6Ej+dW/qeMDr++BOo/Tep9W+mpvxAbQgT0lU6ZCoajdf+GsePqB8lN6F2WMYWQ
         1fnDFxWnemn/qgVSHwSXmZtkNgbPn5kQ2Kcq7It9TVBOaeS6oKSA0oEIoHuPUwrAOQt4
         OsXCfVFNRDLtVNyL+1+syloA+z7LsFpdjeB6ep8kFVJWt1TThtHea+h71IK3eed+6Jrc
         VYoQwdArfMcNfABzn4MIrSc4DScDRngFOgwBVlMHHx14yU+2AjumdqBRX5Xpa/nrPkYm
         jsYA==
X-Gm-Message-State: AGi0PuZh4ZkkG/ZITmwirrQcl5vYuuFY788vNiSHB6vkdwAjyuUSWFMA
        vtxx8Du8mjCpTKsxt6H12lXZxq8GnhfCCMfsL7QepA==
X-Google-Smtp-Source: APiQypLEdn8xTZKTZv9gRqG5Fj19mVLGqJN/fnq7VfXeiz5gV6tiXoLVzH0IzsAvypZbVip6HiFZw00aj2c/+0a/9rE=
X-Received: by 2002:aca:c751:: with SMTP id x78mr3059673oif.163.1587474172245;
 Tue, 21 Apr 2020 06:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
 <87v9luwgc6.fsf@mid.deneb.enyo.de> <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
 <FA73C1DA-B07F-43D5-A9A8-FBC0BAE400CA@dilger.ca>
In-Reply-To: <FA73C1DA-B07F-43D5-A9A8-FBC0BAE400CA@dilger.ca>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 21 Apr 2020 14:02:39 +0100
Message-ID: <CAFEAcA9kktJd8EJ1VCp4a0XikPS9mxmag2GFv0NvwobubQLABw@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 21 Apr 2020 at 00:51, Andreas Dilger <adilger@dilger.ca> wrote:
> Another question I had here is whether the filesystem needs to provide
> 32-bit values for other syscalls, such as stat() and statfs()?  For
> ext4, stat() is not going to return a 64-bit inode number, but other
> filesystems might (e.g. Lustre has a mode to do this).  Similarly,
> should statfs() scale up f_bsize until it can return a 32-bit f_blocks
> value?  We also had to do this ages ago for Lustre when 32-bit clients
> couldn't handle > 16TB filesystems, but that is a single disk today.
>
> Should that be added into F_SET_FILE_32BIT_FS also?

Interesting question. The directory-offset is the thing that's
got peoples' attention because it's what has actually been hit
in real-world situations, but other syscalls have the same
potential problem too. The closest I can think of to a 'general
rule' (in terms of what QEMU would like) would be "behave the
same way you would for a compat32 syscall if you had one, or
how you would behave on an actual 32-bit host".

thanks
-- PMM
