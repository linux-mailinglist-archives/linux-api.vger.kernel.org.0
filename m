Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196F43E19DE
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhHERAl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 13:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbhHERAl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 13:00:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ADAC061798;
        Thu,  5 Aug 2021 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RfOqjCAhidLnWaJDwZvSEiIqNFmEzZQSFH1l77b3IKE=; b=b3DxMoLgrueXZ0QM4bH5bDn9HU
        /n+lDznAfHRFbpt+i/Vy/OMlJgYfw/HnOG/+rxF1Q2EJciRa09mEIsxN1JgXHQ39BlmhokBBHhcjj
        MW1l7pCOMGDbQZ0qPm3QZqeQPyTNoMHFDSUo28oYCS1lwTjJGgha1XopiNZsdzbaqDDTXCymyVeX5
        /ShtA3kJT0HslnzF1UlxcIgpLeE38I64GPIQQNNdzcL0fXApsiiiu8rShmo6KFW+dpwmFeopf8iDw
        lBv1UrgVzyKRnrKZOUa6G907Bt58aF3HDqc8F7iF/gw0gFWcpo/Unrq29ZBCMikUDwa9q8ZKvto4r
        /lz0sL7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBgj5-0067Zp-Sf; Thu, 05 Aug 2021 17:00:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E5B7300084;
        Thu,  5 Aug 2021 19:00:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 381132139818C; Thu,  5 Aug 2021 19:00:10 +0200 (CEST)
Date:   Thu, 5 Aug 2021 19:00:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-api@vger.kernel.org, ldv@strace.io
Subject: Re: [PATCH 18/19] sched: prctl() core-scheduling interface
Message-ID: <YQwZGjjugfJTV2s6@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123309.039845339@infradead.org>
 <20210805165319.GA5916@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805165319.GA5916@asgard.redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 05, 2021 at 06:53:19PM +0200, Eugene Syromiatnikov wrote:
> On Thu, Apr 22, 2021 at 02:05:17PM +0200, Peter Zijlstra wrote:
> > API:
> > 
> >   prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, tgtpid, pidtype, &cookie)
> >   prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, tgtpid, pidtype, NULL)
> >   prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, tgtpid, pidtype, NULL)
> >   prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, srcpid, pidtype, NULL)
> > 
> > where 'tgtpid/srcpid == 0' implies the current process and pidtype is
> > kernel enum pid_type {PIDTYPE_PID, PIDTYPE_TGID, PIDTYPE_PGID, ...}.
> 
> It means that enum pid_tipe has to be a part of UAPI now.  Would you
> like to address it, or rather I'd send a patch?

Please send a patch; I'm more sparse than usual atm.
