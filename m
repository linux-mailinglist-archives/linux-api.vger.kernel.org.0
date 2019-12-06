Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FFC114E54
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 10:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfLFJpi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Dec 2019 04:45:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51197 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFJpi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Dec 2019 04:45:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so7129521wmg.0;
        Fri, 06 Dec 2019 01:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgZXkaerCaq814dwnILX7vYtRFOjbm5DfD5NkTzjaTo=;
        b=K6sdxfwvQPjEECZJH9PvcwUtZP8upA7qjYykUbYxv/o1AeRrnwqEpAUIHj+mcGSUni
         gxVPuZGaG/1KJfRJCfr/EQNC/z6qwV7H+APlCjxBMvCvG2nxOjyZ6mu3CZsCxzie0mv6
         uzeEQTRSC7+HnIxalFxtv9IGHHyzVEkWENSlB02oOlWtYKs5HlIEgoHUS9wFAQ0FbWIt
         DExQCPJ/SfnUPB5NRBf0R7/Gy6U7wM38EvQLYpIZfUGmiNCaroo6J19KMJRs2tpDKIfy
         O4PNOwlIlvz8tIzEr3nRPoNXYcyHz0IRnYOES7E8SjoATIEwl2bI8lfzJHqGQZT6mc0B
         j2vg==
X-Gm-Message-State: APjAAAWAUrQn3jejbOmWy7ROlgRHdFNNE0B5V8nMig43xmtS1Z0DOfkz
        Em0ceBax8/jSaj1NVbjE65izXCkP
X-Google-Smtp-Source: APXvYqxzG3UZEpVj2ra8UPftUD4jNLDT9c/lbi7vIZ4Au8QKO1FCp9GXKuu0+aBLhs5BYLTfzIZ2OA==
X-Received: by 2002:a7b:c24c:: with SMTP id b12mr9616831wmj.16.1575625536360;
        Fri, 06 Dec 2019 01:45:36 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d186sm2986921wmf.7.2019.12.06.01.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 01:45:35 -0800 (PST)
Date:   Fri, 6 Dec 2019 10:45:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mtk.manpages@gmail.com,
        cl@linux.com, cai@lca.pw, akpm@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already
 on the target nodes
Message-ID: <20191206094534.GL28317@dhcp22.suse.cz>
References: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
 <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 06-12-19 00:25:53, John Hubbard wrote:
> On 12/5/19 5:34 PM, Yang Shi wrote:
> > Since commit e78bbfa82624 ("mm: stop returning -ENOENT
> > from sys_move_pages() if nothing got migrated"), move_pages doesn't
> > return -ENOENT anymore if the pages are already on the target nodes, but
> > this change is never reflected in manpage.
> > 
> > Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Qian Cai <cai@lca.pw>
> > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > ---
> >   man2/move_pages.2 | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/man2/move_pages.2 b/man2/move_pages.2
> > index 2d96468..2a2f3cd 100644
> > --- a/man2/move_pages.2
> > +++ b/man2/move_pages.2
> > @@ -192,9 +192,8 @@ was specified or an attempt was made to migrate pages of a kernel thread.
> >   One of the target nodes is not online.
> >   .TP
> >   .B ENOENT
> > -No pages were found that require moving.
> > -All pages are either already
> > -on the target node, not present, had an invalid address or could not be
> > +No pages were found.
> > +All pages are either not present, had an invalid address or could not be
> >   moved because they were mapped by multiple processes.
> >   .TP
> >   .B EPERM
> > 
> 
> whoa, hold on. If I'm reading through the various error paths correctly, then this
> code is *never* going to return ENOENT for the whole function. It can fill in that
> value per-page, in the status array, but that's all. Did I get that right?

You are right. Both store_status and do_move_pages_to_node do overwrite
the error code. So you are right that ENOENT return value is not
possible. I haven't checked since when this is the case. This whole
syscall is a disaster from the API and documentation POV.

Btw. Page states error codes could see some refinements as well.
-- 
Michal Hocko
SUSE Labs
