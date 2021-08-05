Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408C13E19D6
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 18:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhHEQxs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 12:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229685AbhHEQxs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 12:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628182413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7YXGNQbr4wplIdZKTM4CbuCelmPltUOGZ4aCXYZWJxk=;
        b=fGjvgiw5LvOC0flgQYGItRkLIcFKWckLueCax9H4ZQgrIS3+64x4Oz9BVXGlP7AxlJFpx+
        W4ivYQalwPdnor7OU7Z3IRMxNkfR7uvvOQCJ5z+SoSk0HEx5UsAbyZZK3kSB78HVxhTJ3i
        JD/80oTrwlDooyzey8IV5Grm2t7q9xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-BbmM3Ef6MPaMMjyxqDZCKw-1; Thu, 05 Aug 2021 12:53:29 -0400
X-MC-Unique: BbmM3Ef6MPaMMjyxqDZCKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2792E107ACF5;
        Thu,  5 Aug 2021 16:53:27 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CCB760BF4;
        Thu,  5 Aug 2021 16:53:20 +0000 (UTC)
Date:   Thu, 5 Aug 2021 18:53:19 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-api@vger.kernel.org, ldv@strace.io
Subject: Re: [PATCH 18/19] sched: prctl() core-scheduling interface
Message-ID: <20210805165319.GA5916@asgard.redhat.com>
References: <20210422120459.447350175@infradead.org>
 <20210422123309.039845339@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422123309.039845339@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 22, 2021 at 02:05:17PM +0200, Peter Zijlstra wrote:
> API:
> 
>   prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, tgtpid, pidtype, &cookie)
>   prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, tgtpid, pidtype, NULL)
>   prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, tgtpid, pidtype, NULL)
>   prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, srcpid, pidtype, NULL)
> 
> where 'tgtpid/srcpid == 0' implies the current process and pidtype is
> kernel enum pid_type {PIDTYPE_PID, PIDTYPE_TGID, PIDTYPE_PGID, ...}.

It means that enum pid_tipe has to be a part of UAPI now.  Would you
like to address it, or rather I'd send a patch?

