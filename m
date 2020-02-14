Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427B315D7B9
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 13:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgBNMyo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 07:54:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51036 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgBNMyo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Feb 2020 07:54:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so9845176wmb.0;
        Fri, 14 Feb 2020 04:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lkpb9rRHo4fujENU2zWmojrjyhDEzbOkLrKwlWGAzHI=;
        b=odn5KfmkOEXzO5DmlITRe1nM3ky/jX3COFdYW/PAmRWANiKWBpkbn0/aR1Tp43iSho
         FJ/6XDV29eC+8NMJ3qBq5OS8sIaiOJKYGG8T6JPwrdpdpHMw8sGdXoR5gdZWQ2R/LYqt
         jHNLDFsuP9JI0ZOuu7yIMgtNBF7zIOAkT2HkYFwhTBGrqFfGeK8GpUYjb5Jsf9cmC2yl
         VNZQTactkh4iyd9XBo+mJR6EhkI1BPVzkjNu5zrLWMZcevQyVKjPX4yHnWs+0NemFyiw
         r0dArWS/K1WfGnkGSDLLclEs8FpO8Oq4PeRSW/aUa5kCMHf51CJo2FV7RcV7zz3MU6y1
         onoA==
X-Gm-Message-State: APjAAAUROF1TAHjGCg0PJ+J7+WU0qkz6nNBly4TW4HNwWtiysjz+zsgh
        9enWeLZHsSFQZssqJChXSqI=
X-Google-Smtp-Source: APXvYqyq/pp3rU9QYSmKa1vtZ4Hxed4XPSCEZDmPn5fcS2btM8vD5y6Td3bglbrjqa48rUNKiEMOJA==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr4406549wmg.136.1581684882003;
        Fri, 14 Feb 2020 04:54:42 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id r3sm7217635wrn.34.2020.02.14.04.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 04:54:41 -0800 (PST)
Date:   Fri, 14 Feb 2020 13:54:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Christie <mchristi@redhat.com>
Cc:     linux-api@vger.kernel.org, david@fromorbit.com,
        masato.suzuki@wdc.com, damien.lemoal@wdc.com,
        darrick.wong@oracle.com, bvanassche@acm.org,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
Subject: Re: [PATCH 1/1] prctl.2: doc PR_SET/GET_IO_FLUSHER
Message-ID: <20200214125440.GA1839@dhcp22.suse.cz>
References: <20200213182336.6663-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213182336.6663-1-mchristi@redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 13-02-20 12:23:36, Mike Christie wrote:
> This patch documents the PR_SET_IO_FLUSHER and PR_GET_IO_FLUSHER
> prctl commands added to the linux kernel for 5.6 in commit:
> 
> commit 8d19f1c8e1937baf74e1962aae9f90fa3aeab463
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Mon Nov 11 18:19:00 2019 -0600
> 
>     prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
> 
> V3:
> - Replace emulation device example.
> 
> V2:
> - My initial patch for this was very bad. This version is almost 100%
> taken word for word from Dave Chinner's review comments.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>  man2/prctl.2 | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 720ec04e4..58d77bf2e 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1381,6 +1381,30 @@ system call on Tru64).
>  for information on versions and architectures.)
>  Return unaligned access control bits, in the location pointed to by
>  .IR "(unsigned int\ *) arg2" .
> +.TP
> +.B PR_SET_IO_FLUSHER (Since Linux 5.6)
> +An IO_FLUSHER is a user process that the kernel uses to issue IO
> +that cleans dirty page cache data and/or filesystem metadata. The
> +kernel may need to clean this memory when under memory pressure in
> +order to free it. This means there is potential for a memory reclaim
> +recursion deadlock if the user process attempts to allocate memory
> +and the kernel then blocks waiting for it to clean memory before it
> +can make reclaim progress.
> +
> +The kernel avoids these recursion problems internally via a special
> +process state that prevents recursive reclaim from issuing new IO.

I would refrain from describing the internal implementation. The
important part is that this flag tells the kernel that IO_FLUSHER
process gets a special treatment to workaround the deadlock.

So anytime a process is involved in the IO path and the kernel cannot
make a forward progress without it then the flag should be set.

-- 
Michal Hocko
SUSE Labs
