Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B31D2A4060
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 10:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgKCJfx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Nov 2020 04:35:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:45756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbgKCJfx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 3 Nov 2020 04:35:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604396151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mdnaE5WHd3WMJf4PF3zPdDjBC9dHqe3mPUim4j6Vrm0=;
        b=dgATLTXrJ6t+lyH1BezSLnhdbpE71kuY6OaF6sSDtnuZbtlolyL3Mone+q7QzA3KCAO58+
        fpDoiKPK7PIlNOm/U6N38zQsClbCZwcyyr5Ixq0BWrr6bnnRp67pR3y3cdmMhg1yzDO4vp
        ItcEf3niV85TeUDz9BjKvrkGVQ7WZmo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAEB2AD04;
        Tue,  3 Nov 2020 09:35:51 +0000 (UTC)
Date:   Tue, 3 Nov 2020 10:35:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-api@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC]: userspace memory reaping
Message-ID: <20201103093550.GE21990@dhcp22.suse.cz>
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz>
 <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz>
 <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
[...]
> To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> which in addition to sending a kill signal would also reap the
> victim's mm in the context of the caller? Maybe having some code will
> get the discussion moving forward?

Yeah, having a code, even preliminary, might help here. This definitely
needs a good to go from process management people as that proper is land
full of surprises...
-- 
Michal Hocko
SUSE Labs
