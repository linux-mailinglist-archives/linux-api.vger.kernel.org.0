Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DAE250AE
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 15:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfEUNj6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 09:39:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43480 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfEUNj6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 May 2019 09:39:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id u27so13114000lfg.10
        for <linux-api@vger.kernel.org>; Tue, 21 May 2019 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DGZ7ZHyxHghlyk00GjOL+Su8tQVyBxRwxWt505Mwkr8=;
        b=UUsV50XWdVARTWvdiywE4LnO/Bgl22uVqIvj5DiL4yTqSSX691QJuUM5FH7mGHFNYk
         Q0+0Bk1dY9Y5jYUMp6VxvQCJ668wo7gKKnk7wKdAbO6uXmyxdHg1D3dyjo/e1Z67HVYz
         ek1VF3gFyvtiDXkBXE/5DNTwuCl20PqPvKDr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DGZ7ZHyxHghlyk00GjOL+Su8tQVyBxRwxWt505Mwkr8=;
        b=RS9eJ+mY5ErBJJ9Gh4sUl+g7EZPwI1U057A0s2B0u/LP0Py2TLjviNwWBfktHfYw2C
         qTU6feep8+41K5btjwTnSG3sGnXastb95J6/OuDd8YQ7Wh2zLIZLFqJW5GNHxlSPJRDW
         JsvqXWDPinokcg5SPChIbYYMaUa50Do98hWRZPzr22sYnlZmUE2Y0ixiyCOPGb/aQ3q9
         omUlbw1iDAXOf3q+x6S65C833DxvOtJe6tEf78MK4FHpYb8yHzy/D0JpOW0xRVy1VmFD
         tr6jrRbM+4Grw+FneMH42aL8LRvXl1lxrjQ5hVe1YdMiYeVsl4zlrBDrxsYDAlB8KM98
         /dvA==
X-Gm-Message-State: APjAAAVrB0x2hjzqHzw24SHjyCFTvpawisnYRds6Xdjz/Xxh5adKg68i
        mkLnp9b0uREW+saiM1dOR+Wuevf0aiyDdrkZ
X-Google-Smtp-Source: APXvYqy9VOBSFXKLfNL+Ppcf03Ojn4u3dT2Srf4sf8eVcsyswZbIav8iH9LKu3NFIr4da9Rx00Vw+w==
X-Received: by 2002:ac2:5490:: with SMTP id t16mr2238952lfk.154.1558445996105;
        Tue, 21 May 2019 06:39:56 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r26sm4706723lfa.62.2019.05.21.06.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 06:39:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] open: add close_range()
To:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20190521113448.20654-1-christian@brauner.io>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <82d34133-e174-efc3-48ed-332304028595@rasmusvillemoes.dk>
Date:   Tue, 21 May 2019 15:39:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521113448.20654-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 21/05/2019 13.34, Christian Brauner wrote:

> The performance is striking. For good measure, comparing the following
> simple close_all_fds() userspace implementation that is essentially just
> glibc's version in [6]:
> 
> static int close_all_fds(void)
> {
>         DIR *dir;
>         struct dirent *direntp;
> 
>         dir = opendir("/proc/self/fd");
>         if (!dir)
>                 return -1;
> 
>         while ((direntp = readdir(dir))) {
>                 int fd;
>                 if (strcmp(direntp->d_name, ".") == 0)
>                         continue;
>                 if (strcmp(direntp->d_name, "..") == 0)
>                         continue;
>                 fd = atoi(direntp->d_name);
>                 if (fd == 0 || fd == 1 || fd == 2)
>                         continue;
>                 close(fd);
>         }
> 
>         closedir(dir); /* cannot fail */
>         return 0;
> }

Before anybody copy-pastes this, please note that it lacks a check for
fd == dirfd(dir). If all of /proc/self/fd is returned in the first
getdents() syscall one won't notice, but...

Rasmus
