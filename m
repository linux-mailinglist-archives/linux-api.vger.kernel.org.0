Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC40144481
	for <lists+linux-api@lfdr.de>; Tue, 21 Jan 2020 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAUSnd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 Jan 2020 13:43:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41195 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUSnd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 Jan 2020 13:43:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id w62so1929816pfw.8;
        Tue, 21 Jan 2020 10:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TJ+7aT9JrT35zrniT4wJhBHLpa2gWNRqolwPFRdXNl8=;
        b=qwnADoKDat/YhCRnaZl4Dg02qquO4O5tRj7h87WizvuQzcgFVEzYdaUmyepd5QxIGU
         14bhP/TmITwP/o1pyJ6r+hYcpYMfm/O/HFpxkhcF8ERmQ91rIyCuMNDipDC/jdc5dgX6
         fzywdiU6BqqEwQ8FKxgqsveg3J+FC1PyqeWWnh9Cb3poznc9hbOffB8YTjWuVB19U6Hl
         6qBAMnwRE195EBDUaU9B/0sQbzket/zlXZ62HceirL41G2aioBLTjWkQ1gyqsw7ZJTlX
         FW3djklbwl4sIF6g71klJZsJw5pQtEGEC19z1LyvoB6814XyAFviTq8lHnIqowW3n4L7
         ho6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TJ+7aT9JrT35zrniT4wJhBHLpa2gWNRqolwPFRdXNl8=;
        b=MElUNuy7wD/9MVvBsQwSlerHLeaPJKY1TlbxixJ8H7X+rNlbp9tpBvVim3ANdMjmV1
         fWMbCMAQi2PysEq/Sk0L2BN0b/Z6VLaz+tO+uGRMdnxgeao5Sdpk323iKHDxjnmY/6Kz
         KwL92d3h1HvS+rm15xGf8UaCB/wa46oIW8W4F6NY630vnJmpfSDfOa1KONcpA1PHmefn
         +E4W3VobtS5k6SEYFuUF6FFdZvjUxq7QrW880YiQJizSprr7vKeTT1htIVp8U5JHLLLo
         FDOcLB40trkEISxP5sHSG71MR24hcr9sMeuSEOeExL7nP0A8+59yZoWgzScysxYUvUEN
         4Wdg==
X-Gm-Message-State: APjAAAXAYP0YaZwLAnrhsFZ0mqQkFTjXva004PzwqjzIU8kUMihpl0Qn
        SXHoc+3os6JkUYgcNM+izeY=
X-Google-Smtp-Source: APXvYqy6RfD+/6cAJ0+WEpdhy0U/Bt3izVp6T3pODtKsa6rEmIHQdIGbDEjrEZgYJ8KJBrXDBtFceA==
X-Received: by 2002:aa7:864a:: with SMTP id a10mr5913530pfo.233.1579632212761;
        Tue, 21 Jan 2020 10:43:32 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id o7sm46611619pfg.138.2020.01.21.10.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 10:43:31 -0800 (PST)
Date:   Tue, 21 Jan 2020 10:43:29 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
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
Message-ID: <20200121184329.GG140922@google.com>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <f57fb198-4070-d3b4-b6bd-43b29ff40a2c@virtuozzo.com>
 <20200120112722.GY18451@dhcp22.suse.cz>
 <20200120123935.onlls7enjtzenbvt@box>
 <20200120132405.GF18451@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120132405.GF18451@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 20, 2020 at 02:24:05PM +0100, Michal Hocko wrote:
> On Mon 20-01-20 15:39:35, Kirill A. Shutemov wrote:
> > On Mon, Jan 20, 2020 at 12:27:22PM +0100, Michal Hocko wrote:
> > > On Mon 20-01-20 13:24:35, Kirill Tkhai wrote:
> [...]
> > > > Even two threads on common memory need a synchronization
> > > > to manage mappings in a sane way. Managing memory from two processes
> > > > is the same in principle, and the only difference is that another level
> > > > of synchronization is required.
> > > 
> > > Well, not really. The operation might simply attempt to perform an
> > > operation on a specific memory area and get a failure if it doesn't
> > > reference the same object anymore. What I think we need is some form of
> > > a handle to operate on. In the past we have discussed several
> > > directions. I was proposing /proc/self/map_anon/ (analogous to
> > > map_files) where you could inspect anonymous memory and get a file
> > > handle for it. madvise would then operate on the fd and then there
> > > shouldn't be a real problem to revalidate that the object is still
> > > valid. But there was no general enthusiasm about that approach. There
> > > are likely some land mines on the way.
> > 
> > Converting anon memory to file-backed is bad idea and going to backfire.
> 
> I didn't mean to convert. I meant to expose that information via proc
> the same way we do for file backed mappings. That shouldn't really
> require to re-design the way how anonymous vma work IMO. But I haven't
> tried that so there might be many gotchas there.
> 
> There are obvious things to think about though. Such fd cannot be sent
> to other processes (SCM stuff), mmap of the file would have to be
> disallowed and many others I am not aware of. I am not even pushing this
> direction because I am not convinced about how viable it is myself. But
> it would sound like a nice extension of the existing mechanism we have
> and a file based madvise sounds attractive to me as well because we
> already have that.

I am not a fan of fd based approach but I already reserved last argument
of the API as extendable field so we could use the field as "fd" when we
really need that kinds of fine-grained synchronization model if it's not
enough with SGISTOP, freezer and so.
