Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E40139923
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2020 19:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgAMSoN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jan 2020 13:44:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40351 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgAMSoM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jan 2020 13:44:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so5112837pgt.7;
        Mon, 13 Jan 2020 10:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XCFW0Yfpgoj7tyuIPW7yq6i9Mkax8uk0L6HzdUrT4A0=;
        b=UmiF87Pmy7EMCj5XCheHSLZsszlG5ZSZMFIh7wiSNffTKrTM5HIFOk5tBwvl4jcvhV
         MCMl1R1gjAmNlaPSREuj0dM3j5ZCV+zPUSGJ01CAu5cDgZY5wrLKXX6tQF9HjnOPVeG4
         HVsd2tUXtKOOMu3JMD+63nTXdMheehqDAdP6SHAPVg5EL6yJzMyxhWUrwRpPur6OORsF
         t0zFoA7NHCANedW4Ksf5Rje8n8dhVSNb1rhp8ENxsfstADzq4tydyeyqOCyChA1tEO2Q
         mZDSO0H3AmCQRYCR3WpE82jA2FusRTPPMlHy3HYsT/+d8xQTOFYYeqkH7AgG+WipvJ9G
         ophg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XCFW0Yfpgoj7tyuIPW7yq6i9Mkax8uk0L6HzdUrT4A0=;
        b=KJekepyI153Ti0ayNG6ESLtPw6QXhZ2Db0eLxcd8q9JWzCW2TusaRHEb3b7p9TErCn
         xK14+g5es/mHY22T/KFxJGOW+zfnUveybkAagidA3WhYWcdEMK+m0Tzl9fBYOzqVTFsb
         /91Xbp4f9SvJd1bT52Tkn1ocTBlzMMo0nyEbftFGf4sWihd++ua56f0VStQgAhr+HOqa
         48X+OTnDKpJM1oBycNnfkkHEqmvY1EjVExCENpyjodx+n++XF5eQGJcyBYvrNQqC7Dym
         5IaUiGNU8v8dMPFb35OR3Fa2MMvwCz8ftXv9DqqB4Wqed+VcvgJ+LKh+LLtZjV8fMBEq
         eF6g==
X-Gm-Message-State: APjAAAW1KK0/mE0Y0SdG71bP5i4pXPf0ocoqfsswVK+6UstFOZidVZhV
        +8YocLDHjVN7sgnAO8PWJoU=
X-Google-Smtp-Source: APXvYqwqaUyEulapjBKHUnWFZXcRt0mFnT42KUI+pS33SC0ueuwKMg1+GGSrydffaYzLBb4Y/EMrDg==
X-Received: by 2002:a63:a357:: with SMTP id v23mr22421783pgn.223.1578941051972;
        Mon, 13 Jan 2020 10:44:11 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id a16sm14152648pgb.5.2020.01.13.10.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 10:44:10 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:44:08 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
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
        John Dias <joaodias@google.com>
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
Message-ID: <20200113184408.GD110363@google.com>
References: <20200110213433.94739-1-minchan@kernel.org>
 <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
 <20200113104256.5ujbplyec2sk4onn@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113104256.5ujbplyec2sk4onn@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 13, 2020 at 11:42:57AM +0100, Christian Brauner wrote:
> On Mon, Jan 13, 2020 at 11:47:11AM +0300, Kirill Tkhai wrote:

< snip >

> > > +SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> > > +		size_t, len_in, int, behavior, unsigned long, flags)
> > 
> > I don't like the interface. The fact we have pidfd does not mean,
> > we have to use it for new syscalls always. A user may want to set
> > madvise for specific pid from console and pass pid as argument.
> > pidfd would be an overkill in this case.
> > We usually call "kill -9 pid" from console. Why shouldn't process_madvise()
> > allow this?
> > 
> > I suggent to extend first argument to work with both pid and pidfd.
> > Look at what we have for waitid(idtype, id_t id, ...) for example:
> > 
> >        idtype == P_PID
> >               Wait for the child whose process ID matches id.
> > 
> >        idtype == P_PIDFD (since Linux 5.4)
> >               Wait for the child referred to by the PID file descriptor specified in id.  (See pidfd_open(2) for  further  information  on
> >               PID file descriptors.)
> > 
> > We may use @flags argument for this.
> 
> Sorry for chiming in just a comment. Overall, I don't particularly care
> how or if you integrate pidfd here. One thing I would like to point out
> is that we're working on a patch to place new features under pidfd
> specific flags. This e.g. means a pidfd would be only be able to be used
> for madvise operations (or getfd operations) if it was created with that
> specific flag set making it easier to share them with other processes.
> So if you integrate them here I would be quite thankful if you target
> the patchset for the v5.7 merge window, not for v5.6.

Hi Christian,
Sorry but I couldn't understand your point.
Could you clarify what you meant?

Thanks.
