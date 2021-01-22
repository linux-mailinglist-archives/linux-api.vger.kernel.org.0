Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9A2FFEB4
	for <lists+linux-api@lfdr.de>; Fri, 22 Jan 2021 09:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbhAVIwK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 Jan 2021 03:52:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:45340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbhAVIui (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 22 Jan 2021 03:50:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611305388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NEFq9Vo5tsftoHadkZR1mekE9jHN/36+yPVxwO7sQQM=;
        b=YJLj7QPUdvJeZ8wtD8Ll51QT3Sqvet61bFV2X4+SqXNrEcGPF1XZKhnJarw0xIf0rqbwpx
        G6DvicyaYRRvKuFNbczaMhLCI6wkkFm2sKhnRU9VU0oNjBtRh1bbzoxYV3fw7N85RH/uGd
        gV3lDRxqn8CYgwhADWmumUrCyoclbZ8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44016AB9F;
        Fri, 22 Jan 2021 08:49:48 +0000 (UTC)
Date:   Fri, 22 Jan 2021 09:49:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/3] Add error_report_end tracepoint to KFENCE and
 KASAN
Message-ID: <YAqRqwDfWSsjtMRf@alley>
References: <20210121131915.1331302-1-glider@google.com>
 <YAqNoTWfp7HQ9c5m@alley>
 <CAG_fn=WJ7QwBF67H2ND3-3n0XSZ26Xmk=Lvfwn_bpecXqq=NGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=WJ7QwBF67H2ND3-3n0XSZ26Xmk=Lvfwn_bpecXqq=NGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 2021-01-22 09:41:54, Alexander Potapenko wrote:
> On Fri, Jan 22, 2021 at 9:32 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Thu 2021-01-21 14:19:12, Alexander Potapenko wrote:
> > > This patchset adds a tracepoint, error_repor_end, that is to be used by
> > > KFENCE, KASAN, and potentially other bug detection tools, when they
> > > print an error report.
> > > One of the possible use cases is userspace collection of kernel error
> > > reports: interested parties can subscribe to the tracing event via
> > > tracefs, and get notified when an error report occurs.
> > >
> > > v3:
> > >  - dropped the sysfs interface for log collection
> > >  - dropped error_report_start tracepoint
> >
> > Just for record. This approach looks reasonable to me.
> > Thanks for removing the sysfs interface. It would have been
> > a potential can of worms.
> 
> Thanks for the input!
> At least it was premature to touch prink just for the sake of
> collecting some particular crashes.
> Perhaps we can revisit this topic when stronger arguments arise :)

Sure :-)

Best Regards,
Petr
