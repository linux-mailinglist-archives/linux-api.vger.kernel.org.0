Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB101809F
	for <lists+linux-api@lfdr.de>; Wed,  8 May 2019 21:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfEHTos (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 May 2019 15:44:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52722 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfEHTos (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 May 2019 15:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uKC1JyjjYtwBLaIzRTzlSvw/gzaX0p25IvXJ52mSqSs=; b=AwjkqeDEmIXQOdcKAOI6y0NAg
        ycueoqeqjWgFk2U10qsfzTOI+HmvK10yNcdV7CW2VqvXGpz38vTnWqccy5aCNcb6avXKkZBNXeFwf
        BqKLO1CBEKC4KYkmhW970DUS15DtlrRe2qSOmV2bPZbEFJjuO5kxtpxalwQleqoVn8L2zaIs7tUd2
        i/ztBkermxB8Q0B0yRYogV7I76ZQo/IbKI7j/yA6yw49gN8OGzNYc7NtqeLR7669CAj9Pprhb+5rr
        QqYdMuCUakroUHM7yUh7YTAaBjiV35HsCRqf7QZKtzGEnVo+Q2b2O9SaUFc/UQuRdvVnKQr/zRZD/
        Fa4xuRCKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOSUb-0003yo-HJ; Wed, 08 May 2019 19:44:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FB0F98030A; Wed,  8 May 2019 21:44:39 +0200 (CEST)
Date:   Wed, 8 May 2019 21:44:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v8 06/16] sched/core: uclamp: Extend sched_setattr() to
 support utilization clamping
Message-ID: <20190508194439.GF32547@worktop.programming.kicks-ass.net>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-7-patrick.bellasi@arm.com>
 <CAJuCfpH3htcr3xB_Y4nr7HXCdQd1hOdOAXbtZJB1SOt7Of_qbw@mail.gmail.com>
 <20190507111347.4ivnjwbymsf7i3e6@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507111347.4ivnjwbymsf7i3e6@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 07, 2019 at 12:13:47PM +0100, Patrick Bellasi wrote:
> On 17-Apr 15:26, Suren Baghdasaryan wrote:
> > On Tue, Apr 2, 2019 at 3:42 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:

> > > @@ -1056,6 +1100,13 @@ static void __init init_uclamp(void)
> > >  #else /* CONFIG_UCLAMP_TASK */
> > >  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
> > >  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
> > > +static inline int uclamp_validate(struct task_struct *p,
> > > +                                 const struct sched_attr *attr)
> > > +{
> > > +       return -ENODEV;
> > 
> > ENOSYS might be more appropriate?
> 
> Yep, agree, thanks!

No, -ENOSYS (see the comment) is special in that it indicates the whole
system call is unavailable; that is most certainly not the case!
