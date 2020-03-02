Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC1176632
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 22:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCBVmd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 16:42:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34035 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCBVmd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Mar 2020 16:42:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id t3so468957pgn.1;
        Mon, 02 Mar 2020 13:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uCaeMVtpR4WxjCDq5Vfh+a8fRchrnLxaj/CXDjUGdA8=;
        b=J8wu8V/Af3IccEALYEmGUkRRtRQf0eHqJtvdzRy3rVTCrtdP6PW08OeuWgaUNsffoD
         PHBKH9KVyHoLnN8A5n99gnVHaEJwbFuir0FsRkSJrmmpg5ZS2n1IJuivyJXlRI1anHzK
         CvTaKm7FaOIoFr+YSVSml1ojUzRuKiXha2tO8pnjISsheobbcDMu2joOWtIHg/p36K+U
         yUiSplP8t1pld0j2GZOoSTsGrnawOhSlMV8gDnNzpADJ/xQ895qCtOeZZ1QpwEKbkOkl
         sG5VYnyN5sMoH6grcQAfoB0Jd0P5rcSSnCaDIxXBGUsSjx3zqc9288L4XioDhfPKxlJ+
         zCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uCaeMVtpR4WxjCDq5Vfh+a8fRchrnLxaj/CXDjUGdA8=;
        b=RPuO7rlqYJAzlbi496tuq3AvXGwns4EAeQ4ajTtyAxBopMFZPYpUJWFlzKjlOl1Mfk
         PDM3gag1e7QEOaBbAE8EoLuz56/YihbxVPeZFgURcspINcCxLgviw0sUFCwf7TsxgS6b
         IUU/yurFZGYHSxF7jUiwUX8QLKFFhAMQcUungImogGwu7YZK1AR9Okpciwsy8MHlxwz4
         f8t21Lx4FgIW/MXssV9Zf4TCaRTs3+6hAwRA0A++10okLAaY9X6PB+gGwHLl6BhQV8tp
         uSphcQRt7+8dE4s7/+uddzEJr2v/Jm+MQuHArJ2IDUU/SAg/caIuxUqzMXez+2SIGO78
         uiyw==
X-Gm-Message-State: ANhLgQ0ztNdHlM0ryENSM3g39UCrAr9xlI3c7p/x1YF1wl5dXeSiapC3
        lui8l2abpdjjESKgT0XHFllTir0k
X-Google-Smtp-Source: ADFU+vtKj7Kdji9S24ngTS6f/a4A5/EsWr2TF1Am3s89ghNlWHDiZAC9e3EqX8YodZmfHodpOyNTow==
X-Received: by 2002:a63:f501:: with SMTP id w1mr899386pgh.61.1583185351725;
        Mon, 02 Mar 2020 13:42:31 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id ev22sm184390pjb.0.2020.03.02.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:42:30 -0800 (PST)
Date:   Mon, 2 Mar 2020 13:42:28 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com
Subject: Re: [PATCH v7 0/7] introduce memory hinting API for external process
Message-ID: <20200302214228.GB71660@google.com>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302131618.b0f9f0e76d53a69184321884@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302131618.b0f9f0e76d53a69184321884@linux-foundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 02, 2020 at 01:16:18PM -0800, Andrew Morton wrote:
> On Mon,  2 Mar 2020 11:36:23 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
> > application could give hints to kernel what memory range are preferred to be
> > reclaimed. However, in some platform(e.g., Android), the information
> > required to make the hinting decision is not known to the app.
> > Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without any app
> > involvement.
> > 
> > To solve the concern, this patch introduces new syscall - process_madvise(2).
> > Bascially, it's same with madvise(2) syscall but it has some differences.
> > 
> > 1. It needs pidfd of target process to provide the hint
> > 2. It supports only MADV_{COLD|PAGEOUT|MERGEABLE|UNMEREABLE} at this moment.
> >    Other hints in madvise will be opened when there are explicit requests from
> >    community to prevent unexpected bugs we couldn't support.
> > 3. Only privileged processes can do something for other process's address
> >    space.
> > 
> > For more detail of the new API, please see "mm: introduce external memory hinting API"
> > description in this patchset.
> 
> Thanks, I grabbed these.
> 
> I massaged the patch titles significantly - mainly to alert readers to
> the fact that we're proposing a new syscall.
> 
> Is a manpage for process_madvise(2) being prepared?

I will prepare it, Thanks!
