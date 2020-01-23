Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD144146070
	for <lists+linux-api@lfdr.de>; Thu, 23 Jan 2020 02:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgAWBlg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Jan 2020 20:41:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41800 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWBlf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 22 Jan 2020 20:41:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id w62so722957pfw.8;
        Wed, 22 Jan 2020 17:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n52djEzsUpHwVAF4RVRzRPi7lkDjnzr2BXfsJcxQMZY=;
        b=t8+zvXARhvvy6HrrT9NtUAOtP4drE9Y80izI7cJbe582ROnZUWKx4ANYOFb9WQ/B+e
         RnlKlordyD1HEtNfFAa2Gba5pYUQuvunpUa6rMou4Gmzd8BkST536SQczpQ7i38i/RqX
         Ri10YBvsGMB8PjTR7WYo00bbs/uj8hEC+FSLJVZ/dukpXQ0piio9RkB5MTtY4t6TebRF
         Waso1ZdkU/XTwavK5MBsMqXYzCl6KzH81TyzwWlTRH+qbFWZpu5uX6Y2P1uwAnD0/lwK
         6Iy9sU/jtO67/ZGGfm51RGz0AuGU/AaTPiIl05YNpR73HlpMgAXEbhv/O+joqG+ku1t6
         9J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n52djEzsUpHwVAF4RVRzRPi7lkDjnzr2BXfsJcxQMZY=;
        b=ILgQvcxyunCQlak0MGQMQDv9pCGuwBaoLN53Nac/Zcy9PxbE+t/rqYgG/iwpvQgMyp
         SUzL2aZUzYssGdF+Hzl5p6z5/WbFOq4Q4MomAD4KqIM2f1ZctyuJgmGx+Lq+4i+dwqMF
         GvE7v3WHOJwD7A1U3vbbhKq2FBvttAE09bq0j9kjz454WZtKM95blk/ODSiwV9ffMHDo
         mCzwBB8yoi+cGX6THpdUcyilojEJqt6GI3YR9VbC+Xa9wzYFjtwSSwvYeCb41MFH03um
         tWn2JqBtcbNuiPAmxpf3BHkH1pILHPRZHTuhBgUnOJ1ouGpPo5AS9qsaleL/kTG6ensw
         GA8w==
X-Gm-Message-State: APjAAAWYbmFWDhtqToaz8pRfWyHzNIBxhDnwglMjRbPo9hLAjgFFHu1E
        Autr3wAvoAR3smQPr8qznOcIhpGi
X-Google-Smtp-Source: APXvYqy1nHeYVhLof1rS2+iL6f/2vYHKSuGNizob3qzpmyerg6oFidHREkp0OJ/AzwUL8trYRDzPww==
X-Received: by 2002:a63:744f:: with SMTP id e15mr1365651pgn.344.1579743694890;
        Wed, 22 Jan 2020 17:41:34 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id b26sm312332pgn.1.2020.01.22.17.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 17:41:33 -0800 (PST)
Date:   Wed, 22 Jan 2020 17:41:31 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     sspatil@google.com, kirill@shutemov.name,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        oleksandr@redhat.com, surenb@google.com, timmurray@google.com,
        dancol@google.com, sonnyrao@google.com, bgeffon@google.com,
        hannes@cmpxchg.org, shakeelb@google.com, joaodias@google.com,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200123014131.GA249784@google.com>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com>
 <20200117212653.7uftw3lk35oykkmb@box>
 <20200119161431.GA94410@google.com>
 <20200120075825.GH18451@dhcp22.suse.cz>
 <20200121183212.GF140922@google.com>
 <20200122082853.GS29276@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122082853.GS29276@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jan 22, 2020 at 09:28:53AM +0100, Michal Hocko wrote:
> On Tue 21-01-20 10:32:12, Minchan Kim wrote:
> > On Mon, Jan 20, 2020 at 08:58:25AM +0100, Michal Hocko wrote:
> [...]
> > > The interface really has to be robust to future potential usecases.
> > 
> > I do understand your concern but for me, it's chicken and egg problem.
> > We usually do best effort to make something perfect as far as possible
> > but we also don't do over-engineering without real usecase from the
> > beginning.
> > 
> > I already told you how we could synchronize among processes and potential
> > way to be extended Daniel suggested(That's why current API has extra field
> > for the cookie) even though we don't need it right now.
> 
> If you can synchronize with the target task then you do not need a
> remote interface. Just use ptrace and you are done with it.

As I mentioned in other reply, we want to do in caller's context, not
callee's one because target processes stay in little cores, which are
much slower than the core the manager lives in.
The other reason is the apps are already freezed so they couldn't response
by ptrace.

> 
> > If you want to suggest the other way, please explain why your idea is
> > better and why we need it at this moment.
> 
> I believe I have explained my concerns and why they matter. All you are
> saying is that you do not care because your particular usecase doesn't
> care. And that is a first signal of a future disaster when we end up
> with a broken and unfixable interface we have to maintain for ever.

We already had suggested cookie and fd based approaches so I reserved a
argument for that to make the API extendable.
Thing is currently it's a just optimization idea since we have several
ways to sychronize processes(e.g., signal, cgroup freezer, userfaultfd
and so). It's a just matter of granularity, not necessary one we should
introduce it from the beginnig.
If someone needs that kinds of fine-grained consistency, we could extend
it then. And that's the usual way we make progress when we couldn't
know the future.

What do you want to see further?
