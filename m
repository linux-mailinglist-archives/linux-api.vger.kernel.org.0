Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6DE1A774F
	for <lists+linux-api@lfdr.de>; Tue, 14 Apr 2020 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437640AbgDNJZx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Apr 2020 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437618AbgDNJZu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Apr 2020 05:25:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C8C0A3BD0;
        Tue, 14 Apr 2020 02:25:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so6243584wrx.4;
        Tue, 14 Apr 2020 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vmqi2aM4XOZP0IN9SViui540QPwsxI0PmRmeUzpXYLg=;
        b=gdYckNsSf9IdAzHBRYdN8hM87PRWUJHuCuO/hDHXzEsxtPtPH81aWc1zdlgRbL+4DD
         FGf2if+2ywuFsBwALdtGu6uhKk1c1HKz+G1rjGyWzrDesAV5QBY+/BDfvMjT/4LeaymN
         IYpvGsQC2pv9AeA95+yEdSeyUnhCVr+H9lpl20G/f4n0CB20vteNbqfgDRHNg5O0j67p
         JeZzCKS+f0nRWNmmqLrJeWsJ3sEdeU3Y2TrF+XMzjzmCyQvMdudEYLWEULzgJhEDQx/k
         MwnHWF1CKb6ge3cHqgQLYOV9MGofaOMLZ9kEoQ9nUaLEws6GAYhGptWvNN9kWxdiul8V
         8eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vmqi2aM4XOZP0IN9SViui540QPwsxI0PmRmeUzpXYLg=;
        b=loKZS23E6LJIkGsBcHEDeRlUB2E2Utn39VwN/END/n+ojYbhYcj7EN6rfjk574hdXd
         i+drCxhz/ddl4mM6AvtLXgPxh7lvKZHBcIAtUOFTswxv4oScKT4QxRio87nrP8+5dv4H
         8F1GN2a+bYpzV5C3SkcRQkBN1tKOYkXlW4yrHjnSSU/7nJ7t1ZsxNxNRIs9egmueyBHS
         Kltb5qi0QRM0Dow+PadVIH2Ibmy3jdpOT28ykGUARCWDB4zUBxhOSTzeSSHyDnbqK9eC
         YHNZXvIgPone7h7PgjHuGhkdrMK+vpYmRJp/+mkmRquEgmgtFigh0RerCazhmP8jI1Vu
         pJ5w==
X-Gm-Message-State: AGi0PubA7yGVj5ebQdbgOr9A3hJ2ulZ+Buxuz2NDKePqqB4MpSRgbMDM
        Zdc8jCYW8D2yLw9UKfyeKC4=
X-Google-Smtp-Source: APiQypKTO1wTU6mF1TGRsHy0LE/7K8OOHb75/p+OGn33YiRSvSrLcOOSlfwVnZk9yYdcdfrAoIri7w==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr23975422wrp.114.1586856349109;
        Tue, 14 Apr 2020 02:25:49 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id y15sm18665399wro.68.2020.04.14.02.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 02:25:48 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, jstancek@redhat.com, mszeredi@redhat.com,
        linux-api@vger.kernel.org, chrubis@suse.cz, tytso@mit.edu,
        bfields@fieldses.org, pgajdos@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH] utimensat: immutable flag returns -EPERM
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-man@vger.kernel.org
References: <20170605141827.21420-1-rgoldwyn@suse.de>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <48ae74c5-29ca-aa71-4618-7f25e12d544f@gmail.com>
Date:   Tue, 14 Apr 2020 11:25:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20170605141827.21420-1-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Goldwyn,

On 6/5/17 4:18 PM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Linux kernel commit 337684a1746f "fs: return EPERM on immutable inode"
> changed (nd unified the return value of the utimensat(2) from -EACCES
> to -EPERM in case of an immutable flag. Modify the man page to
> reflect the same.
> 
> The entire discussion of returning the correct return value is at:
> http://lists.linux.it/pipermail/ltp/2017-January/003424.html
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Thanks. Patch (finally) applied.

Cheers,

Michael

> ---
>  man2/utimensat.2 | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/man2/utimensat.2 b/man2/utimensat.2
> index f77d0b42a..c0bdf8808 100644
> --- a/man2/utimensat.2
> +++ b/man2/utimensat.2
> @@ -238,10 +238,7 @@ or both
>  .I tv_nsec
>  values are
>  .BR UTIME_NOW ,
> -and either:
> -.RS
> -.IP * 3
> -the effective user ID of the caller does not match
> +and the effective user ID of the caller does not match
>  the owner of the file,
>  the caller does not have write access to the file,
>  and the caller is not privileged
> @@ -249,7 +246,7 @@ and the caller is not privileged
>  .B CAP_FOWNER
>  or the
>  .B CAP_DAC_OVERRIDE
> -capability); or,
> +capability).
>  .\" But Linux 2.6.22 was broken here.
>  .\" Traditionally, utime()/utimes() gives the error EACCES for the case
>  .\" where the timestamp pointer argument is NULL (i.e., set both timestamps
> @@ -271,9 +268,6 @@ capability); or,
>  .\" and the permissions of the directory to which
>  .\" .I fd
>  .\" refers do not allow searches.
> -.IP *
> -the file is marked immutable (see
> -.BR chattr (1)).
>  .\" EXT2_IMMUTABLE_FL and similar flags for other filesystems.
>  .RE
>  .TP
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
