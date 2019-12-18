Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBCE8124416
	for <lists+linux-api@lfdr.de>; Wed, 18 Dec 2019 11:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfLRKRP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Dec 2019 05:17:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53010 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLRKRP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Dec 2019 05:17:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so1201006wmc.2;
        Wed, 18 Dec 2019 02:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XFN+U1ADviQEf7OrflnIoN2G55vNUzSvIie0WpgXkiw=;
        b=QrErX+meiueVQW3QytCbNDNWlw3jUt4tjOlE+JVj6hMPjAC5ohU4Gdqu62ECfEZoJ8
         z/frPdcbh5/x+z9ycuIc4wcMyw0C8Aoxu2lyaa3eg4my1cqWdkHRBQtiniY9flFfaIZ3
         pvNLG085H/Z7N50iep+TAuBCyPMb5RRoA3+OIDXDBaTj7MgSSze7t7aoRYGX5F6pJv6n
         8sNqn8c0uEXGCJB5dBGvSYG2vojeq81cIXWRpP2CEUB95a0TfeyZ62pTETRgfaTHE21O
         sbPxguWD8cJ2c3N9hk8OOh7HXiIRMqL0WXZcXspIWTiazhHu2OtHT4A0Ws9huq/5AeOE
         18JA==
X-Gm-Message-State: APjAAAWPLguRRriaiqrZSvHWj9wGpKV2vX+5Ey/GxvERe4Z4XIiI8ZFf
        9/uw/Hsr28uCUimZWAKGIis=
X-Google-Smtp-Source: APXvYqykrVcjXHG4bpSwgcJCKmDU9jRLSl37r+vkvO/nwYidCthgZg7RHxZQfFO/Sv0VN+i0ohgFvw==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr2316993wmm.143.1576664233380;
        Wed, 18 Dec 2019 02:17:13 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id x132sm5878901wmg.0.2019.12.18.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 02:17:12 -0800 (PST)
Date:   Wed, 18 Dec 2019 11:17:11 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, cl@linux.com,
        cai@lca.pw, akpm@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already
 on the target nodes
Message-ID: <20191218101711.GB21485@dhcp22.suse.cz>
References: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
 <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
 <95170ea5-5b62-9168-fcd9-93b43330a1b4@linux.alibaba.com>
 <092adc11-7039-9343-7067-0e0199c9dc13@gmail.com>
 <51dd767a-221f-882d-c7f6-45bd0c217a67@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51dd767a-221f-882d-c7f6-45bd0c217a67@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 17-12-19 23:36:09, John Hubbard wrote:
[...]
> diff --git a/man2/move_pages.2 b/man2/move_pages.2
> index 2d96468fa..1bf1053f2 100644
> --- a/man2/move_pages.2
> +++ b/man2/move_pages.2
> @@ -191,12 +191,6 @@ was specified or an attempt was made to migrate pages of a kernel thread.
>  .B ENODEV
>  One of the target nodes is not online.
>  .TP
> -.B ENOENT
> -No pages were found that require moving.
> -All pages are either already
> -on the target node, not present, had an invalid address or could not be
> -moved because they were mapped by multiple processes.
> -.TP
>  .B EPERM
>  The caller specified
>  .B MPOL_MF_MOVE_ALL
> 
> ...But I'm not sure if we should change the implementation, instead, so
> that it *can* return ENOENT. That's the main question to resolve before
> creating any more patches, I think.

I would start by dropping any note about ENOENT first. I am not really
sure there is a reasonable usecase for it but maybe somebody comes up
with something and only then we should consider it.

Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

ideally with a kernel commit which removed the ENOENT.
-- 
Michal Hocko
SUSE Labs
