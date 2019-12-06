Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0474D114CE1
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 08:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLFHsA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Dec 2019 02:48:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56076 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfLFHsA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Dec 2019 02:48:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so6749357wmj.5;
        Thu, 05 Dec 2019 23:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qtb1WWUgl9wqPcOJD9MpTiHXbCPls9RWYFCWxX8gA38=;
        b=lm8i9v8tLSpKiqaGRPa9F2IzSo+r+1zi8aYqVh7MUfJ26Hi+dxEp5LiNcLbjSLj98U
         vR6l4ibPkEO2xL76FZoj2WHmrDvg0LuPjh/2pkJEDuDqdCND/b9OY/rfYCmyFSCA3mno
         y9MPYkL5vfCfrFzFh7A5svvxnS13xLPXWMYRVQn182/5wg6Dtj4E/LE0qydGXE+1pEZN
         UeH/iSSkoW8WE8UnhawYnReKvsC8cyYhHXsDb7/TTKHM/duUeaLD2N8XU6qyb2op2sbq
         7QOTJ6aOAFmkITF4W1LfVnAIdSXeONuEtIHf3st98Z60nc39aSt1JgWiByvB38owi1lw
         80Ug==
X-Gm-Message-State: APjAAAV/YEvQLlIDxH8V/PFykz7gE/fq4hhI/xTyfwyH8XO6DYA7eWUX
        vHk4HAa9GNZMC+kgHaDYI8w=
X-Google-Smtp-Source: APXvYqzgdNukLlA3rCQmi7utZ2az51NLS1sN4LCMUjSaTNjqwhS+410uEl0P6YTtOQzNh9pp1JteSA==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr9307143wmd.171.1575618478227;
        Thu, 05 Dec 2019 23:47:58 -0800 (PST)
Received: from localhost (ip-37-188-170-11.eurotel.cz. [37.188.170.11])
        by smtp.gmail.com with ESMTPSA id u18sm15209133wrt.26.2019.12.05.23.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:47:57 -0800 (PST)
Date:   Fri, 6 Dec 2019 08:47:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mtk.manpages@gmail.com, cl@linux.com, jhubbard@nvidia.com,
        cai@lca.pw, akpm@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already
 on the target nodes
Message-ID: <20191206074756.GI28317@dhcp22.suse.cz>
References: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 06-12-19 09:34:50, Yang Shi wrote:
> Since commit e78bbfa82624 ("mm: stop returning -ENOENT
> from sys_move_pages() if nothing got migrated"), move_pages doesn't
> return -ENOENT anymore if the pages are already on the target nodes, but
> this change is never reflected in manpage.
> 
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Qian Cai <cai@lca.pw>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  man2/move_pages.2 | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/man2/move_pages.2 b/man2/move_pages.2
> index 2d96468..2a2f3cd 100644
> --- a/man2/move_pages.2
> +++ b/man2/move_pages.2
> @@ -192,9 +192,8 @@ was specified or an attempt was made to migrate pages of a kernel thread.
>  One of the target nodes is not online.
>  .TP
>  .B ENOENT
> -No pages were found that require moving.
> -All pages are either already
> -on the target node, not present, had an invalid address or could not be
> +No pages were found.
> +All pages are either not present, had an invalid address or could not be
>  moved because they were mapped by multiple processes.

I would rather not put any specifics here because those reasons might
differ in future. I would simply go with "No pages were found that
require or could be moved."

-- 
Michal Hocko
SUSE Labs
