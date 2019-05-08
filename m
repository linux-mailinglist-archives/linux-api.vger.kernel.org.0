Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29DDF17FF8
	for <lists+linux-api@lfdr.de>; Wed,  8 May 2019 20:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfEHSmL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 May 2019 14:42:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHSmL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 May 2019 14:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QkojuoKjlRx99FreCBXd8uMCKzFV4ejE/54/aBGxim4=; b=dT+DeY8lE/Z1A7+znLacFSsaP
        DZ5Fl9+uTUZQBO1AyhdDIvkusWBYz4k6WCStuCcIX960z9J377EmXYz4l0m/17/X+ZMLiytQufq/e
        pFgthAalIqOkUtE7hWoQAW8QMFgUHQCnN7m2cU44mPWj8ehnTCXbrJpL9/oRpqPjYbFxj+MiwzzAn
        89p+vATzYA40ZmPKFKoPv4SQh6wjR3ykHB7uTSILi+b964qVuVlU0i0nDKR7Dwxv2g7qnUYBkrI43
        Sk6MY//bPrr1Nkq+kb+4F0ORDLUX7m67XDBUPAs1hpYuFA9VasufR18ZAWjD5xcWZbYwvmoQuwGmD
        hFU9tSVTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hORW0-0007R8-Cv; Wed, 08 May 2019 18:42:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E708980308; Wed,  8 May 2019 20:42:02 +0200 (CEST)
Date:   Wed, 8 May 2019 20:42:02 +0200
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
Message-ID: <20190508184202.GA32547@worktop.programming.kicks-ass.net>
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
> Add a privileged interface to define a system default configuration via:
> 
>   /proc/sys/kernel/sched_uclamp_util_{min,max}

Isn't the 'u' in "uclamp" already for util?
