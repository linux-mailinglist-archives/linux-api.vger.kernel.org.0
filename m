Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0224B3D
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 11:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfEUJLm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 05:11:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35338 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfEUJLm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 May 2019 05:11:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id t87so8746750pfa.2;
        Tue, 21 May 2019 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aOt4vo5keUTXDvxZZjRtcBm1aK7jMfHXMFBxDuIODzA=;
        b=P5we8Zz6H+6S4VTlk2sRyHDyYEYpXZzybP9tIIBSzd43r9y5MSZBdRXPlBJ3lryTA+
         FWOEAmz8w+mqOLE+LcNWuJ/ve9kPQPP8/phO01R+hpObYwiJzOU+mo9bnHu8oNM243hL
         clYHRejJlOIAMzdHvAOiJEhHVDOa2d3OqbZ7SHHr7QP9bdRstiaxodxpUI3z/JqLn0l4
         CuVATlGmo/EyAaq4qPMaqhxYBgbZoh/4BquhmIPGWKdQjcfQP+ng4zk+hWfL7XFYdTlr
         x1rygty1O865cqXgXvCFhBnp7eKJuEOmFIKJmbeFTSlJ6axhVPY/QRu6T1S+43OepZ+a
         qeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aOt4vo5keUTXDvxZZjRtcBm1aK7jMfHXMFBxDuIODzA=;
        b=IWiM2Mq9+pg5bAF5xG1HRGTS+i2Er+q7WP8zuqyb3/e7h8K/8NnaPU8Wn490o22OPs
         gW64O1ZWTOzxtig9Q+TheHEks2vykxAjqXukr7hZKgkYmI+4GFhFLAU8boZSKfWIEFsd
         tZnA/UmdWOgrrU79c2myfXzNTUTyEIP+c5gVYYqkDKfxLRbScDEUh3OkzTzUiE4NiGt9
         dqobrjTOEEEPOFmOeDYyos/eTFbxg9EcBpq5EiBybkNGRMhgRQbCHt2UW3eWfT2YyoI+
         CjTBt5ccno5D+RdADqgR1GEdCdfyS8wcBPJznwwCIIPXjZmngpDhsMC2VWp8cLVQrQo7
         HYJQ==
X-Gm-Message-State: APjAAAU2FJtWHrDFVh9IZsdlikKwOW/FWU5z1iW+XYtH8USe0kPGfyQk
        LttTk225t0xHDJsXa6J1AcE=
X-Google-Smtp-Source: APXvYqzQ29qPyHCPNtNMZdW9Eoc/R5M5CuB8zMitb7IkSgZN/cNPBHHU2P0y4NCtkKDQjLnHnvvwbA==
X-Received: by 2002:aa7:980e:: with SMTP id e14mr86228912pfl.142.1558429901695;
        Tue, 21 May 2019 02:11:41 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id s19sm20707713pfh.176.2019.05.21.02.11.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 02:11:40 -0700 (PDT)
Date:   Tue, 21 May 2019 18:11:34 +0900
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
Subject: Re: [RFC 1/7] mm: introduce MADV_COOL
Message-ID: <20190521091134.GA219653@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-2-minchan@kernel.org>
 <20190520081621.GV6836@dhcp22.suse.cz>
 <20190520225419.GA10039@google.com>
 <20190521060443.GA32329@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521060443.GA32329@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 21, 2019 at 08:04:43AM +0200, Michal Hocko wrote:
> On Tue 21-05-19 07:54:19, Minchan Kim wrote:
> > On Mon, May 20, 2019 at 10:16:21AM +0200, Michal Hocko wrote:
> [...]
> > > > Internally, it works via deactivating memory from active list to
> > > > inactive's head so when the memory pressure happens, they will be
> > > > reclaimed earlier than other active pages unless there is no
> > > > access until the time.
> > > 
> > > Could you elaborate about the decision to move to the head rather than
> > > tail? What should happen to inactive pages? Should we move them to the
> > > tail? Your implementation seems to ignore those completely. Why?
> > 
> > Normally, inactive LRU could have used-once pages without any mapping
> > to user's address space. Such pages would be better candicate to
> > reclaim when the memory pressure happens. With deactivating only
> > active LRU pages of the process to the head of inactive LRU, we will
> > keep them in RAM longer than used-once pages and could have more chance
> > to be activated once the process is resumed.
> 
> You are making some assumptions here. You have an explicit call what is
> cold now you are assuming something is even colder. Is this assumption a
> general enough to make people depend on it? Not that we wouldn't be able
> to change to logic later but that will always be risky - especially in
> the area when somebody want to make a user space driven memory
> management.

Think about MADV_FREE. It moves those pages into inactive file LRU's head.
See the get_scan_count which makes forceful scanning of inactive file LRU
if it has enough size based on the memory pressure.
The reason is it's likely to have used-once pages in inactive file LRU,
generally. Those pages has been top-priority candidate to be reclaimed
for a long time.

Only parts I am aware of moving pages into tail of inactive LRU are places
writeback is done for pages VM already decide to reclaim by LRU aging or
destructive operation like invalidating but couldn't completed. It's
really strong hints with no doubt.

>  
> > > What should happen for shared pages? In other words do we want to allow
> > > less privileged process to control evicting of shared pages with a more
> > > privileged one? E.g. think of all sorts of side channel attacks. Maybe
> > > we want to do the same thing as for mincore where write access is
> > > required.
> > 
> > It doesn't work with shared pages(ie, page_mapcount > 1). I will add it
> > in the description.
> 
> OK, this is good for the starter. It makes the implementation simpler
> and we can add shared mappings coverage later.
> 
> Although I would argue that touching only writeable mappings should be
> reasonably safe.
> 
> -- 
> Michal Hocko
> SUSE Labs
