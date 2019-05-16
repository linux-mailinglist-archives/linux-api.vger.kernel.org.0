Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6872C2007B
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 09:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfEPHrP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 03:47:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:50674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbfEPHrP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 16 May 2019 03:47:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CECF8ADCB;
        Thu, 16 May 2019 07:47:13 +0000 (UTC)
Date:   Thu, 16 May 2019 09:47:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190516074713.GK16651@dhcp22.suse.cz>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
 <20190514145122.GG4683@dhcp22.suse.cz>
 <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
 <20190515065311.GB16651@dhcp22.suse.cz>
 <20190515145151.GG16651@dhcp22.suse.cz>
 <20190515151557.GA23969@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515151557.GA23969@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 15-05-19 17:15:57, Greg KH wrote:
> On Wed, May 15, 2019 at 04:51:51PM +0200, Michal Hocko wrote:
> > [Cc Suren and Minchan - the email thread starts here 20190514131654.25463-1-oleksandr@redhat.com]
> > 
> > On Wed 15-05-19 08:53:11, Michal Hocko wrote:
> > [...]
> > > I will try to comment on the interface itself later. But I have to say
> > > that I am not impressed. Abusing sysfs for per process features is quite
> > > gross to be honest.
> > 
> > I have already commented on this in other email. I consider sysfs an
> > unsuitable interface for per-process API.
> 
> Wait, what?  A new sysfs file/directory per process?  That's crazy, no
> one must have benchmarked it :)

Just to clarify, that was not a per process file but rather per process API.
Essentially echo $PID > $SYSFS_SPECIAL_FILE

-- 
Michal Hocko
SUSE Labs
