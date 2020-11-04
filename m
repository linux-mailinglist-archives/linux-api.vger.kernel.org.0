Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FC02A6EFA
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 21:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgKDUk5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 15:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbgKDUk5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 15:40:57 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11FC0613D3;
        Wed,  4 Nov 2020 12:40:56 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t14so17581436pgg.1;
        Wed, 04 Nov 2020 12:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vKEi14cNRFouABmJsM8FD4P756MUI2SVDsa+n1MVR14=;
        b=EtrGdebgHFk/4A89uzUGpcfqE27DscZj2SO2F1xgL63Ji+x6NgEPxP5RlyxX9kbI1E
         zUbq5h22iTFruYNhwjZctYqQ2znC5lWkUUfa/DSJBGBoRcRn/HU3641hahqVcx4zmizX
         KVn+vKBbH3s2fvTzgkC4gpQIHQZkDpzjvR7vo8hRlBv8ElWDSqbxansPvBSMubiS4FQ1
         YpTUKiEVZ7ivF9wUyQdmWGkWT7NszMtDsmzV1IjcYznLfubNXjJZkixhwT6EH2u277MD
         Xk38BgfuNGJIAyoaqSgUMTSTM1r8ItMRPimZWijNohkbZ+qNWgQ48CkIqXx0BJw//Bfq
         RyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vKEi14cNRFouABmJsM8FD4P756MUI2SVDsa+n1MVR14=;
        b=oxaBE2wccoJpThJ4VeJcWrgJAP8fQ730621eHj/S4+5d0eQwJ/P6c9oPB60jyiPAli
         eiLnSH7AVihsm/13gSeo3YktZBHJSI+GfWbGG0P9hOEd6xtxOxgr1HLZgcu4RqNn1iX6
         DYlpULVNYzCkEFMTelmh8a0Z8kg4llK7GHJJb2N6A5pUyzlcIr/DOTKy9J3QQu+k3MZQ
         FlS+3e9XUTT4x3ZesjJ2qpFEVqt21PpVn4Z0daTn+Xg8BHcQsCywOkopu+Pc49iXxZZ0
         6xff4DZvbzKPnvEZ3ZGWvyXCoHPS+QPsBkiHzo9R/NW/lPJBfMDVpH/2m52Vo/dDzuXe
         WHQw==
X-Gm-Message-State: AOAM532wu2rAXEfogIXo85/E9RevV3n7g2nXRvZ1ja29DDNmLi258Ect
        O48HRLUIa37do/oB38irGjw=
X-Google-Smtp-Source: ABdhPJwr8ecu1sp3XOsCzhebLAX6Zfm5DmkXXS5hFKQLJqcIb3MA/SqmiUwhd7ha5GfeEFk0/0LMKA==
X-Received: by 2002:a17:90a:182:: with SMTP id 2mr5651967pjc.21.1604522455968;
        Wed, 04 Nov 2020 12:40:55 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id 16sm3265066pfp.163.2020.11.04.12.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:40:54 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 4 Nov 2020 12:40:51 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-api@vger.kernel.org,
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
Message-ID: <20201104204051.GA3544305@google.com>
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz>
 <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz>
 <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz>
 <20201103213228.GB1631979@google.com>
 <20201104065844.GM21990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104065844.GM21990@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 04, 2020 at 07:58:44AM +0100, Michal Hocko wrote:
> On Tue 03-11-20 13:32:28, Minchan Kim wrote:
> > On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> > > On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> > > [...]
> > > > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > > > which in addition to sending a kill signal would also reap the
> > > > victim's mm in the context of the caller? Maybe having some code will
> > > > get the discussion moving forward?
> > > 
> > > Yeah, having a code, even preliminary, might help here. This definitely
> > > needs a good to go from process management people as that proper is land
> > > full of surprises...
> > 
> > Just to remind a idea I suggested to reuse existing concept
> > 
> >     fd = pidfd_open(victim process)
> >     fdatasync(fd);
> >     close(fd);
> 
> I must have missed this proposal. Anyway, are you suggesting fdatasync
> to act as a destructive operation?

write(fd) && fdatasync(fd) are already destructive operation if the file
is shared.

You don't need to reaping as destruptive operation. Rather than, just
commit on the asynchrnous status "write file into page cache and commit
with fsync" and "killing process and commit with fsync".
