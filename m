Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02132AF8E
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 09:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfE0Hts (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 03:49:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37674 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0Htr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 May 2019 03:49:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id p15so6739127pll.4;
        Mon, 27 May 2019 00:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UAaLUDeqiG1NP6oRWwwXznCvAzla34GzLiXiS6KmTYY=;
        b=dcaj37bCGUBkTgKtlwvXFPEIuX2F6UmuMUU5vrFtZ3MCfY5mEozm2J0Kxt0xiWbjBx
         p5j/krk+oCCMX1wl7lfkOqs2PJiP+4y2Z+jHyS0+VH4lZyT8b+FbwGyjtxfgsgGgiw2n
         bqMXvJcr5CFZM6QbRYbqqY/0oHmhio8Ky1QfKX7vrgL8O/9ZqYFYACTfyFVYnnsrZQXz
         TnVe+KKgKAUnZERuRC4nlyRiVrVCrror364HWIUX+r5ew7kKXg/j+cepsCNa/GZpqq2r
         hpVaPnIJdna7Ev8sKDaKYlw9eZsUkuUvf8AeN+KaKWaDR4v4cvYgJZP4OkNhyBsv0E2T
         eo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UAaLUDeqiG1NP6oRWwwXznCvAzla34GzLiXiS6KmTYY=;
        b=XUYaIYpvb3EJFaoy2T9C9nu1mrDgJHZ7SsOfaGvj9xfgs7fbqKOnE/je7952m4g8J5
         HkSXHd5rx9XFvkTVDSnXxJTGMG+CYRbyxCrk9jyg6wnHXbeWyy0O1f1KapHTb3UCEy6X
         Dk8ToiQkMlRIIti9XmDd5vP+cP3s/YZpKRuvwoxoO04piOKK9SLdjyiN0sQ10BjreLJL
         YPYCy0zvz9PJQEJA9b6t9FXtmKiChtvQWYOUkORZaindsONGDj3QNymMCIDMS20VVK0e
         XJljQP8j8KEKH1zABCLZOxD9JANt0QcB9972kr8wDCV9JClKdaPA1R5TO0fYlUaouK+q
         NnRA==
X-Gm-Message-State: APjAAAX6VPsJFIn0SUyAYGwLsLr068dzlT42/DDohq/3a4t4qRyd3nsG
        3Pa+uzdQEdBmiyYoB/G8adk=
X-Google-Smtp-Source: APXvYqysI7IOkBNmcR/djcrJ/5JIth+TrYyPAhn/ojlSa+KZOHOuhmEpThUW7Eam0JapW4Wf5PUOuw==
X-Received: by 2002:a17:902:2e81:: with SMTP id r1mr110527179plb.0.1558943386837;
        Mon, 27 May 2019 00:49:46 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id k190sm146239pgk.28.2019.05.27.00.49.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 00:49:45 -0700 (PDT)
Date:   Mon, 27 May 2019 16:49:40 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 6/7] mm: extend process_madvise syscall to support vector
 arrary
Message-ID: <20190527074940.GB6879@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-7-minchan@kernel.org>
 <20190520092258.GZ6836@dhcp22.suse.cz>
 <20190521024820.GG10039@google.com>
 <20190521062421.GD32329@dhcp22.suse.cz>
 <20190521102613.GC219653@google.com>
 <20190521103726.GM32329@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521103726.GM32329@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 21, 2019 at 12:37:26PM +0200, Michal Hocko wrote:
> On Tue 21-05-19 19:26:13, Minchan Kim wrote:
> > On Tue, May 21, 2019 at 08:24:21AM +0200, Michal Hocko wrote:
> > > On Tue 21-05-19 11:48:20, Minchan Kim wrote:
> > > > On Mon, May 20, 2019 at 11:22:58AM +0200, Michal Hocko wrote:
> > > > > [Cc linux-api]
> > > > > 
> > > > > On Mon 20-05-19 12:52:53, Minchan Kim wrote:
> > > > > > Currently, process_madvise syscall works for only one address range
> > > > > > so user should call the syscall several times to give hints to
> > > > > > multiple address range.
> > > > > 
> > > > > Is that a problem? How big of a problem? Any numbers?
> > > > 
> > > > We easily have 2000+ vma so it's not trivial overhead. I will come up
> > > > with number in the description at respin.
> > > 
> > > Does this really have to be a fast operation? I would expect the monitor
> > > is by no means a fast path. The system call overhead is not what it used
> > > to be, sigh, but still for something that is not a hot path it should be
> > > tolerable, especially when the whole operation is quite expensive on its
> > > own (wrt. the syscall entry/exit).
> > 
> > What's different with process_vm_[readv|writev] and vmsplice?
> > If the range needed to be covered is a lot, vector operation makes senese
> > to me.
> 
> I am not saying that the vector API is wrong. All I am trying to say is
> that the benefit is not really clear so far. If you want to push it
> through then you should better get some supporting data.

I measured 1000 madvise syscall vs. a vector range syscall with 1000
ranges on ARM64 mordern device. Even though I saw 15% improvement but
absoluate gain is just 1ms so I don't think it's worth to support.
I will drop vector support at next revision.

Thanks for the review, Michal!
