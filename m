Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EABCD5061E
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 11:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfFXJtp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 05:49:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46854 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfFXJtp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 05:49:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so13115565wrw.13
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uMxls29yTU5DXxSZZDmKdMa/UJzxCvP3CHiUiso6rY8=;
        b=ahHUisnqGggxi5Om3/YR8YhvER6syrrtsn254t8h29TKNZt91WURxPN1L4V1C9VSTa
         4sYT97NwAFDV/Eu0nBSBnquJ+PWd2pLDGvWWv3ukYuawZF1zPG+ha8A1z4hnjD3A7IvR
         g8zmDVOyPtWFljzZHb/8Jlc9S4IjEIrehCCyHYZCt03XsnSj6iXV5JDExg5rHqFUEB0q
         w6qD9kai+Eh5woYeO4nLGAEZnL1dtOP5MBMqSyevkYjOPKm9fOAziolDm2NfmoN1cbxg
         z0E3BppsWFWMbctUxvc82Bo9uICnsh5+Tic+bdF7j/2fEuLXviv326Q/PUKMWZRwH1+q
         NFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uMxls29yTU5DXxSZZDmKdMa/UJzxCvP3CHiUiso6rY8=;
        b=j3oU3Lz33LUL5VeKMRnq3CXXavr7H2Hfbk0ZAZrm6GY0VPTeJdo08G9Z9e51x3wXIp
         4rBYhd3wFkqZH7mNIlGF7YrvSimYjkNIfZWb0CJ0qz2lNaGvW+vESKvblglwgSoNJwlm
         16FRt4J89sGQciU4ZhLl8vJd3hkGzMXsvjoEaQzuFKmpvOQr9FsMX5z+Laj+1PMbAL+E
         aqDf5YKruqJ67KJvcCaUvm4kDh1t5ADt7Ll/xkSgMWAUyY5GXtdwLqm6EhHMZAwlKQf6
         DGFXLlUMxyu/X6jNIk4EtsfulZCrZhvr0HIm/lD94HZkY6h9h8qlccWrcz4kXSTbs4E/
         o0tw==
X-Gm-Message-State: APjAAAU1D3UDJh0yaGhGcKhh/B9APVBeyXXW6XefOR/9ZfxLaLAXGM8d
        wbV3Nzqj7nB0MxiD6sAYOS07RA==
X-Google-Smtp-Source: APXvYqyDG4Weyx6NRWhKYAqtLeKlZSx8B4fVIaDVkmaFDjev3UxPvLHB2ZuKWtqPwKzQz4yzqbRz8w==
X-Received: by 2002:adf:e5d1:: with SMTP id a17mr17374709wrn.278.1561369783154;
        Mon, 24 Jun 2019 02:49:43 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id z76sm13987064wmc.16.2019.06.24.02.49.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 02:49:42 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:49:41 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] CLONE_PIDFD: do not use the value pointed by
 parent_tidptr
Message-ID: <20190624094940.24qrteybbcp25wq7@brauner.io>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
 <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
 <20190621170613.GA26182@altlinux.org>
 <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
 <20190623112717.GA20697@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190623112717.GA20697@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Jun 23, 2019 at 02:27:17PM +0300, Dmitry V. Levin wrote:
> Userspace needs a cheap and reliable way to tell whether CLONE_PIDFD
> is supported by the kernel or not.
> 
> While older kernels without CLONE_PIDFD support just leave unchanged
> the value pointed by parent_tidptr, current implementation fails with
> EINVAL if that value is non-zero.
> 
> If CLONE_PIDFD is supported and fd 0 is closed, then mandatory pidfd == 0
> pointed by parent_tidptr also remains unchanged, which effectively
> means that userspace must either check CLONE_PIDFD support beforehand
> or ensure that fd 0 is not closed when invoking CLONE_PIDFD.
> 
> The check for pidfd == 0 was introduced during v5.2 release cycle
> by commit b3e583825266 ("clone: add CLONE_PIDFD") to ensure that
> CLONE_PIDFD could be potentially extended by passing in flags through
> the return argument.
> 
> However, that extension would look horrendous, and with introduction of
> clone3 syscall in v5.3 there is no need to extend legacy clone syscall
> this way.
> 
> So remove the pidfd == 0 check.  Userspace that needs to be portable
> to kernels without CLONE_PIDFD support is advised to initialize pidfd
> with -1 and check the pidfd value returned by CLONE_PIDFD.
> 
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Reviewed-by: Christian Brauner <christian@brauner.io>

Thank you Dmitry, queueing this up for rc7.

> ---
>  kernel/fork.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 75675b9bf6df..39a3adaa4ad1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1822,8 +1822,6 @@ static __latent_entropy struct task_struct *copy_process(
>  	}
>  
>  	if (clone_flags & CLONE_PIDFD) {
> -		int reserved;
> -
>  		/*
>  		 * - CLONE_PARENT_SETTID is useless for pidfds and also
>  		 *   parent_tidptr is used to return pidfds.
> @@ -1834,16 +1832,6 @@ static __latent_entropy struct task_struct *copy_process(
>  		if (clone_flags &
>  		    (CLONE_DETACHED | CLONE_PARENT_SETTID | CLONE_THREAD))
>  			return ERR_PTR(-EINVAL);
> -
> -		/*
> -		 * Verify that parent_tidptr is sane so we can potentially
> -		 * reuse it later.
> -		 */
> -		if (get_user(reserved, parent_tidptr))
> -			return ERR_PTR(-EFAULT);
> -
> -		if (reserved != 0)
> -			return ERR_PTR(-EINVAL);
>  	}
>  
>  	/*
> -- 
> ldv
