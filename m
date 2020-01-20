Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11ED142EFB
	for <lists+linux-api@lfdr.de>; Mon, 20 Jan 2020 16:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgATPov (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jan 2020 10:44:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36130 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATPov (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Jan 2020 10:44:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so71674wma.1;
        Mon, 20 Jan 2020 07:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JRmMzO219tY5iJKWdolr3waKgeawvzdw0ymvmaVvtNg=;
        b=Id6TxFBF1RlxNA1DFDzBmOYNe/lTlNUz+iWd8m14XTFOMHy1dXntWfum9EZcOMZQeT
         Mz4Vkmzlk5WUb578a2FMvGwmle/fYiuVfSegs8+mNVGKdQpd9lvh1dYh+45WaGvI5ZrU
         afAc3c7yf8zu6HLfma2ZKiuErew1wfPigTrQHW+PLI/mDQHBKh8QtKFdIfjEWxXQpFMa
         JpGzK/Xbm73QtgsGJPQBAjG73LtdG4hCZUlud6Euvrt8oyAiacdayPYNsHKXtoHDeRqo
         ijB/8iT/0X5Hvh87t43rBeJksl0qM4XpszHiYC/F/ziDFzRNVXxDM1ACYy9ITzzRS+gM
         LP9g==
X-Gm-Message-State: APjAAAULJfoY/6YuI1Io5mnF7XMg4Jee8YdCFpYFa5JuaZ35ZAVcFev8
        rKJ+Ct1EdCrwEe4YNPWYiV1AxBGU
X-Google-Smtp-Source: APXvYqzAIcLxEjmh3U3YLGcGTq8iaQY80TZAl/1LPfWmpjMPs4mLoPEkFXfSbbEY9QWlzESIg/1FRg==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr15320wmc.78.1579535088464;
        Mon, 20 Jan 2020 07:44:48 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v3sm47734043wru.32.2020.01.20.07.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 07:44:47 -0800 (PST)
Date:   Mon, 20 Jan 2020 16:44:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, christian.brauner@ubuntu.com,
        sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200120154447.GL18451@dhcp22.suse.cz>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <f57fb198-4070-d3b4-b6bd-43b29ff40a2c@virtuozzo.com>
 <20200120112722.GY18451@dhcp22.suse.cz>
 <20200120123935.onlls7enjtzenbvt@box>
 <20200120132405.GF18451@dhcp22.suse.cz>
 <20200120142132.srf4igph4zmecu7b@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120142132.srf4igph4zmecu7b@box>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 20-01-20 17:21:32, Kirill A. Shutemov wrote:
> On Mon, Jan 20, 2020 at 02:24:05PM +0100, Michal Hocko wrote:
> > On Mon 20-01-20 15:39:35, Kirill A. Shutemov wrote:
> > > On Mon, Jan 20, 2020 at 12:27:22PM +0100, Michal Hocko wrote:
> > > > On Mon 20-01-20 13:24:35, Kirill Tkhai wrote:
> > [...]
> > > > > Even two threads on common memory need a synchronization
> > > > > to manage mappings in a sane way. Managing memory from two processes
> > > > > is the same in principle, and the only difference is that another level
> > > > > of synchronization is required.
> > > > 
> > > > Well, not really. The operation might simply attempt to perform an
> > > > operation on a specific memory area and get a failure if it doesn't
> > > > reference the same object anymore. What I think we need is some form of
> > > > a handle to operate on. In the past we have discussed several
> > > > directions. I was proposing /proc/self/map_anon/ (analogous to
> > > > map_files) where you could inspect anonymous memory and get a file
> > > > handle for it. madvise would then operate on the fd and then there
> > > > shouldn't be a real problem to revalidate that the object is still
> > > > valid. But there was no general enthusiasm about that approach. There
> > > > are likely some land mines on the way.
> > > 
> > > Converting anon memory to file-backed is bad idea and going to backfire.
> > 
> > I didn't mean to convert. I meant to expose that information via proc
> > the same way we do for file backed mappings. That shouldn't really
> > require to re-design the way how anonymous vma work IMO. But I haven't
> > tried that so there might be many gotchas there.
> > 
> > There are obvious things to think about though. Such fd cannot be sent
> > to other processes (SCM stuff), mmap of the file would have to be
> > disallowed and many others I am not aware of. I am not even pushing this
> > direction because I am not convinced about how viable it is myself. But
> > it would sound like a nice extension of the existing mechanism we have
> > and a file based madvise sounds attractive to me as well because we
> > already have that.
> 
> If the fd cannot be passed around or mmaped what does it represent?

Because it is a cookie maintained by the kernel.

> And how is it different from plain address?

Kernel can revalidate that the given fd is denoting the vma it was
created for and simply fail with ENOENT or whatever suits if somebody
did unmap and mmap to the same address.
-- 
Michal Hocko
SUSE Labs
