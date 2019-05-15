Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C28B1EA32
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 10:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfEOIdY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 04:33:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:34892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfEOIdY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 04:33:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92802AFA7;
        Wed, 15 May 2019 08:33:22 +0000 (UTC)
Date:   Wed, 15 May 2019 10:33:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190515083321.GC16651@dhcp22.suse.cz>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
 <20190514145122.GG4683@dhcp22.suse.cz>
 <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
 <20190515065311.GB16651@dhcp22.suse.cz>
 <20190515073723.wbr522cpyjfelfav@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515073723.wbr522cpyjfelfav@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 15-05-19 09:37:23, Oleksandr Natalenko wrote:
[...]
> > This is way too generic. Please provide something more specific. Ideally
> > with numbers. Why those usecases cannot use an existing interfaces.
> > Remember you are trying to add a new user interface which we will have
> > to maintain for ever.
> 
> For my current setup with 2 Firefox instances I get 100 to 200 MiB saved
> for the second instance depending on the amount of tabs.

What does prevent Firefox (an opensource project) to be updated to use
the explicit merging?

[...]

> Answering your question regarding using existing interfaces, since
> there's only one, madvise(2), this requires modifying all the
> applications one wants to de-duplicate. In case of containers with
> arbitrary content or in case of binary-only apps this is pretty hard if
> not impossible to do properly.

OK, this makes more sense. Please note that there are other people who
would like to see certain madvise operations to be done on a remote
process - e.g. to allow external memory management (Android would like
to control memory aging so something like MADV_DONTNEED without loosing
content and more probably) and potentially other madvise operations.
Or maybe we need a completely new interface other than madvise.

In general, having a more generic API that would cover more usecases is
definitely much more preferable than one ad-hoc API that handles a very
specific usecase. So please try to think about a more generic
-- 
Michal Hocko
SUSE Labs
