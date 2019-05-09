Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E19218A35
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 15:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEINCZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 09:02:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfEINCZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 May 2019 09:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zs0QwpA986xBV8SHwzSyfAtMa6UMTB6GSBeVfJrlmPg=; b=oKXDYugMnMb7TATIUk352eY8M
        kC6Q/0/Jfs4X6iuyC4CytddI06oUr//opY/9OmboGGQ/FEay0t6+gZSljBPYHUygpF79SIRuIUfi0
        fl2WudmUn0sK/3wI5H3kfPg9cVNSvnPeec+KeswOh9cMMiUq1aC1kfBp5nI3gd+FT8gz67iXXT4ZR
        GPGvL+GDSHLzMDNKN35dsw3jI3j41na34Gu0Y0+z76vGXKOW/TOmP4lSWLBz8OUjyaonmVzNLiVtr
        PngCxAwPnRi1oILq5cJ10hM3MRkkgNxnDiqGsKdq6g44YQ4PI4VDy03xXxwL6bspqaY9cnDEjTva6
        87iTWVlzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOigj-0006DQ-JA; Thu, 09 May 2019 13:02:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5ECA32006F48C; Thu,  9 May 2019 15:02:15 +0200 (CEST)
Date:   Thu, 9 May 2019 15:02:15 +0200
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
Subject: Re: [PATCH v8 00/16] Add utilization clamping support
Message-ID: <20190509130215.GV2623@hirez.programming.kicks-ass.net>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402104153.25404-1-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 02, 2019 at 11:41:36AM +0100, Patrick Bellasi wrote:
> Series Organization
> ===================
> 
> The series is organized into these main sections:
> 
>  - Patches [01-07]: Per task (primary) API
>  - Patches [08-09]: Schedutil integration for FAIR and RT tasks
>  - Patches [10-11]: Integration with EAS's energy_compute()

Aside from the comments already provided, I think this is starting to
look really good.

Thanks!

>  - Patches [12-16]: Per task group (secondary) API

I still have to stare at these, but maybe a little later...
