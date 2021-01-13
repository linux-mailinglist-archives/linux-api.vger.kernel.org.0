Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8D92F4CF8
	for <lists+linux-api@lfdr.de>; Wed, 13 Jan 2021 15:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbhAMOUU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Jan 2021 09:20:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:53050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbhAMOUU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 13 Jan 2021 09:20:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610547573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tzRzrPRO0sG/PZufpslx/p2FJilLPOCaqNLlQqECfqs=;
        b=UvQrTaLu7nYoCtIzCLWCIYq3tb6NEJPytiVqqoCEKB62YzAOmeqtN2hegBQiDVO8kuaCpj
        ED+QEXUULnOJw0Q82GfNp8xuiu14SB0JY4+5rscFK53iM4TdmfsvVpT1nk+psAFQR49KZp
        YY+qRxJrDbcLR1q+7TtV0AO72OyOZyQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 750D1AD19;
        Wed, 13 Jan 2021 14:19:33 +0000 (UTC)
Date:   Wed, 13 Jan 2021 15:19:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Edgar Arriaga =?iso-8859-1?Q?Garc=EDa?= 
        <edgararriaga@google.com>, Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for
 process_madvise
Message-ID: <20210113141932.GB22493@dhcp22.suse.cz>
References: <20210111170622.2613577-1-surenb@google.com>
 <20210112074629.GG22493@dhcp22.suse.cz>
 <CAJuCfpHazLXJ1rpJQ+w9=8-O==rzz3yEVuVtSn-sYMS+a3FoXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHazLXJ1rpJQ+w9=8-O==rzz3yEVuVtSn-sYMS+a3FoXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 12-01-21 10:12:03, Suren Baghdasaryan wrote:
> On Mon, Jan 11, 2021 at 11:46 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 11-01-21 09:06:22, Suren Baghdasaryan wrote:
> > > process_madvise currently requires ptrace attach capability.
> > > PTRACE_MODE_ATTACH gives one process complete control over another
> > > process. It effectively removes the security boundary between the
> > > two processes (in one direction). Granting ptrace attach capability
> > > even to a system process is considered dangerous since it creates an
> > > attack surface. This severely limits the usage of this API.
> > > The operations process_madvise can perform do not affect the correctness
> > > of the operation of the target process; they only affect where the data
> > > is physically located (and therefore, how fast it can be accessed).
> >
> > Yes it doesn't influence the correctness but it is still a very
> > sensitive operation because it can allow a targeted side channel timing
> > attacks so we should be really careful.
> 
> Sorry, I missed this comment in my answer. Possibility of affecting
> the target's performance including side channel attack is why we
> require CAP_SYS_NICE.

OK. It would be really good to document that in the man page. From the
current wording it seems we already rely on this cap for migration on a
remote process which is not the same thing but it roughly falls into the
similar category.
-- 
Michal Hocko
SUSE Labs
