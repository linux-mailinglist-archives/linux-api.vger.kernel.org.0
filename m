Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C732D2C325F
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 22:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgKXVMy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 16:12:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729696AbgKXVMy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 16:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606252372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXDgjUSKVmaMxP5Ej5vJVP3Yboi59btyCQFSTLeCsr0=;
        b=EbtIrHkXtEWF9RCc7EGRL2YLulF0o8Ha0o+kuKa9xQcq1RpD0ZB1XIYydY7Mz32kGfyx2i
        DyOY5aTKvLIbxI4bTvFhgNFNul7gCOuWeJ8WxV/GSeIg2KgY070E8JGEbHVJf9yvwWlU2y
        D/bnUHa15WMzFIc3zP7SJfu/aSRnyIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-dCyNPPViNvmmpX4NcWdmLA-1; Tue, 24 Nov 2020 16:12:50 -0500
X-MC-Unique: dCyNPPViNvmmpX4NcWdmLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0A3880EDB7;
        Tue, 24 Nov 2020 21:12:48 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF1D11F0;
        Tue, 24 Nov 2020 21:12:48 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 958BF416D899; Tue, 24 Nov 2020 16:52:03 -0300 (-03)
Date:   Tue, 24 Nov 2020 16:52:03 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm: introduce sysctl file to flush per-cpu vmstat
 statistics
Message-ID: <20201124195203.GB3635@fuller.cnet>
References: <20201117162805.GA274911@fuller.cnet>
 <20201117180356.GT29991@casper.infradead.org>
 <alpine.DEB.2.22.394.2011171855500.215602@www.lameter.com>
 <20201117202317.GA282679@fuller.cnet>
 <alpine.DEB.2.22.394.2011201817320.248402@www.lameter.com>
 <72f598ea-9fdf-537d-0b3a-aac2251d347c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72f598ea-9fdf-537d-0b3a-aac2251d347c@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 24, 2020 at 06:12:29PM +0100, Vlastimil Babka wrote:
> On 11/20/20 7:20 PM, Christopher Lameter wrote:
> > On Tue, 17 Nov 2020, Marcelo Tosatti wrote:
> > 
> > > > So what we would need would be something like a sysctl that puts the
> > > > system into a quiet state by completing all workqueue items. Idle all
> > > > subsystems that need it and put the cpu into NOHZ mode.
> > > 
> > > Are you suggesting that instead of a specific file to control vmstat
> > > workqueue only, a more generic sysctl could be used?
> > 
> > Yes. Introduce a sysctl to quiet down the system. Clean caches that will
> > trigger kernel threads and whatever else is pending on that processor.
> 
> Please CC linux-api on future postings that introduce stuff like this.

Thanks, will do.

> > > About NOHZ mode: the CPU should enter NOHZ automatically as soon as
> > > there is a single thread running, so unclear why that would be needed.
> > 
> > There are typically pending actions that still trigger interruptions.
> > 
> > If you would immediately quiet down the system if there is only one thread
> > runnable then you would compromise system performance through frequent
> > counter folding and cache cleaning etc.
> 
> If someone goes through the trouble of setting up NOHZ, these disruptions
> should be only temporary and happen during the setup, no?

There is no way for the userspace application to know when the
disruptions are gone (vmstat work function executed).

But yes, they are temporary and happen during setup.

