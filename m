Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD32D18039
	for <lists+linux-api@lfdr.de>; Wed,  8 May 2019 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfEHTHp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 May 2019 15:07:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEHTHp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 May 2019 15:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W1mDe44mRWxpcie1JocOtRQCGEH73zOucp82U4iQ/vg=; b=ltarrk97rbDZkLdBdVU5iO5eJ
        2Qv6cSMQirqBxyjmTlLeKWzwsQX1Xp5MppJjvJPeGXppmfH1Hl/eA/fsvsm0XdFJwYjCVR8wznOIk
        gk1qyBNsD4g4uUEZjuiXW0+jN3DRgpzwecVL5WtW4v8A1s3+ZDeD7wyhg1flpaZPW+0D1BJkm7hF+
        RHDfQmz7XLbpfVG9HeNPmIl2s3UEoaeRRCdS6yfr6NJDlHwVu0yF7obnQsePnLUI9fDcWs82kzEdB
        Qburk7jVHP9sx+JYBKUxLj1Bh1SsGGuzbnNY/5QnscgfRPR6Bxqw8fU3GEIxVNLlCkphE8sPRkiKw
        QRjlIletA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hORuh-0008EJ-Pr; Wed, 08 May 2019 19:07:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7FDB98030A; Wed,  8 May 2019 21:07:33 +0200 (CEST)
Date:   Wed, 8 May 2019 21:07:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
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
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v8 04/16] sched/core: uclamp: Add system default clamps
Message-ID: <20190508190733.GC32547@worktop.programming.kicks-ass.net>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-5-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402104153.25404-5-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 02, 2019 at 11:41:40AM +0100, Patrick Bellasi wrote:
> +static inline struct uclamp_se
> +uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
> +{
> +	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
> +	struct uclamp_se uc_max = uclamp_default[clamp_id];
> +
> +	/* System default restrictions always apply */
> +	if (unlikely(uc_req.value > uc_max.value))
> +		return uc_max;
> +
> +	return uc_req;
> +}
> +
> +static inline unsigned int
> +uclamp_eff_bucket_id(struct task_struct *p, unsigned int clamp_id)
> +{
> +	struct uclamp_se uc_eff;
> +
> +	/* Task currently refcounted: use back-annotated (effective) bucket */
> +	if (p->uclamp[clamp_id].active)
> +		return p->uclamp[clamp_id].bucket_id;
> +
> +	uc_eff = uclamp_eff_get(p, clamp_id);
> +
> +	return uc_eff.bucket_id;
> +}
> +
> +unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
> +{
> +	struct uclamp_se uc_eff;
> +
> +	/* Task currently refcounted: use back-annotated (effective) value */
> +	if (p->uclamp[clamp_id].active)
> +		return p->uclamp[clamp_id].value;
> +
> +	uc_eff = uclamp_eff_get(p, clamp_id);
> +
> +	return uc_eff.value;
> +}

This is 'wrong' because:

  uclamp_eff_value(p,id) := uclamp_eff(p,id).value

Which seems to suggest the uclamp_eff_*() functions want another name.

Also, suppose the above would be true; does GCC really generate better
code for the LHS compared to the RHS?
