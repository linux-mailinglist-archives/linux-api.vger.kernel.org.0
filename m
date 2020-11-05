Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1672A846F
	for <lists+linux-api@lfdr.de>; Thu,  5 Nov 2020 18:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgKERHz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Nov 2020 12:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKERHy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Nov 2020 12:07:54 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A697AC0613CF;
        Thu,  5 Nov 2020 09:07:54 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id g19so294640pji.0;
        Thu, 05 Nov 2020 09:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a/G37s3/UjwAPE/W5DNIRy/pjvBqWVcyDTzt23Xt9No=;
        b=mqoyA/2lbsg4coNSgnM4EjAG79SXTnyZlihW2wqmX1PzcvLeeyq0DCjJTLPmaQn19y
         VGh3W3mRcc4G2HLm0nmQdr6uNQNr3rspKyor8teQLb6KRMM4582aahBULwVQ30UO6Wd5
         MwJ1fxYX7gqpVWpcQVNnm1W5/y8y9IkeyavBbZqDHaiU8qg8AN4yCV9Zu+xtXdc0+yWh
         wNfCFVXyIEcgG7MvCqcKz4qVy/Yj9NHEqR+I0PjewUdN3cN4Pshh+gu633MsObX29CRE
         9wo6/cjJb0gpL/B0aPl81aImbRNCBxvIK1N3ofge6QeMBQmjRoUkKW/kZpjKHiS03JJV
         oKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a/G37s3/UjwAPE/W5DNIRy/pjvBqWVcyDTzt23Xt9No=;
        b=D3uAhVEMS0rjiyew67uA+dRBC2eUmuN8skCRZNTA+LFWm3jM5Mm4KUzjhlF/xDdKYX
         KsUZokmJVKfIAtrdOVZxAKyhQUMmDk6oy8LFxXRB5LWZe54JKEFZPk7dwMMKRzYBAfLY
         jjtcjh1IhROV9IYaFr2jF9mBZeGxfLVV3dwDbnCzPzLK1zAf111o9FibVb09F2F02+r8
         JnH/dr37aupDqiEXQc85vyJ8kQ0cXTM0CIbzkgZ1orqhQqIK64v5agH4Gdi0SHiCduSo
         jRw81+i5WMo5Zm59JUS45acY43u7V0LgSiNQ69mKWfIITpeHzvF3eGmofL6SHeUNDxF4
         trDQ==
X-Gm-Message-State: AOAM5322j5kFXHFfXvPF9vsGuW+jBEwf0zd/OoZeJnXLcNFKbWz3lZpg
        rYfNLWiIFCaQVbG32O1vOTM=
X-Google-Smtp-Source: ABdhPJy8ziNqMeMIAGWHm6Jef5Dh09mbR/hfx8blme5oiPK5YqEWx6aPza7yu3sEL9EBV+kaB69JTQ==
X-Received: by 2002:a17:90a:540f:: with SMTP id z15mr3346326pjh.111.1604596074184;
        Thu, 05 Nov 2020 09:07:54 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id r8sm2913540pgl.57.2020.11.05.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:07:53 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 5 Nov 2020 09:07:50 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC]: userspace memory reaping
Message-ID: <20201105170750.GA387236@google.com>
References: <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz>
 <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz>
 <20201103213228.GB1631979@google.com>
 <20201104065844.GM21990@dhcp22.suse.cz>
 <20201104204051.GA3544305@google.com>
 <20201105122012.GD21348@dhcp22.suse.cz>
 <CAJuCfpF5zAif97-uK8M+-fJhd0pab4fMPDMUNkAXYOB3MC7aXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpF5zAif97-uK8M+-fJhd0pab4fMPDMUNkAXYOB3MC7aXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 05, 2020 at 08:50:58AM -0800, Suren Baghdasaryan wrote:
> On Thu, Nov 5, 2020 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 04-11-20 12:40:51, Minchan Kim wrote:
> > > On Wed, Nov 04, 2020 at 07:58:44AM +0100, Michal Hocko wrote:
> > > > On Tue 03-11-20 13:32:28, Minchan Kim wrote:
> > > > > On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> > > > > > On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> > > > > > [...]
> > > > > > > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > > > > > > which in addition to sending a kill signal would also reap the
> > > > > > > victim's mm in the context of the caller? Maybe having some code will
> > > > > > > get the discussion moving forward?
> > > > > >
> > > > > > Yeah, having a code, even preliminary, might help here. This definitely
> > > > > > needs a good to go from process management people as that proper is land
> > > > > > full of surprises...
> > > > >
> > > > > Just to remind a idea I suggested to reuse existing concept
> > > > >
> > > > >     fd = pidfd_open(victim process)
> > > > >     fdatasync(fd);
> > > > >     close(fd);
> > > >
> > > > I must have missed this proposal. Anyway, are you suggesting fdatasync
> > > > to act as a destructive operation?
> > >
> > > write(fd) && fdatasync(fd) are already destructive operation if the file
> > > is shared.
> >
> > I am likely missing something because fdatasync will not destroy any
> > underlying data. It will sync
> >
> > > You don't need to reaping as destruptive operation. Rather than, just
> > > commit on the asynchrnous status "write file into page cache and commit
> > > with fsync" and "killing process and commit with fsync".
> >
> > I am sorry but I do not follow. The result of the memory reaping is a
> > data loss. Any private mapping will simply lose it's content. The caller
> > will get EFAULT when trying to access it but there is no way to
> > reconstruct the data. This is everything but not resembling what I see
> > f{data}sync is used for.
> 
> I think Minchan considers f{data}sync as a "commit" operation. So
> write+f{data}sync would mean we write and commit written data,
> kill+f{data}sync would mean we kill and commit that kill (reclaim the
> resources).

If people doesn't like f{data}sync, ftruncate? My point is let's reuse
exising API since we have pidfd.

What I don't like about SIGKILL_SYNC is that it might introduce several
SIGXXX_SYNC later.
