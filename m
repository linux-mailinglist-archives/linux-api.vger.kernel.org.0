Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB9A2B846E
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgKRTKZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 14:10:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:56318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgKRTKY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Nov 2020 14:10:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605726622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PHqRgFGLF7++rqv3Lsk3obYtItSqoxTqnImH6UJRi/k=;
        b=Ns+TtYTHur4leXJTxMzoo9DXqqyYd+4vWOKF4laQo54XNVwJNpx5I4XcyD1N0KtmfExnzn
        ujqDIYvw9vlQF7h5AaepV8GurtLZI/6QOJ1nIjFcygxUf0f4TMMrewls6JVsJ4AIxWRQRZ
        P4IBCP/Ra5X2Ot4N5jkXSxvPfch+QQM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3577BC5A;
        Wed, 18 Nov 2020 19:10:22 +0000 (UTC)
Date:   Wed, 18 Nov 2020 20:10:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
Message-ID: <20201118154334.GT12284@dhcp22.suse.cz>
References: <20201113173448.1863419-1-surenb@google.com>
 <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
 <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
 <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
 <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com>
 <20201113171810.bebf66608b145cced85bf54c@linux-foundation.org>
 <CAJuCfpH-Qjm5uqfaUcfk0QV2zC76uL96FQjd88bZGBvCuXE_aA@mail.gmail.com>
 <20201113181632.6d98489465430a987c96568d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113181632.6d98489465430a987c96568d@linux-foundation.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 13-11-20 18:16:32, Andrew Morton wrote:
[...]
> It's all sounding a bit painful (but not *too* painful).  But to
> reiterate, I do think that adding the ability for a process to shoot
> down a large amount of another process's memory is a lot more generally
> useful than tying it to SIGKILL, agree?

I am not sure TBH. Is there any reasonable usecase where uncoordinated
memory tear down is OK and a target process which is able to see the
unmapped memory?
-- 
Michal Hocko
SUSE Labs
