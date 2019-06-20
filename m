Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C68CF4C9A5
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2019 10:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfFTIoP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 04:44:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41456 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTIoP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 04:44:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id m7so1096931pls.8;
        Thu, 20 Jun 2019 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sYUDpApbnrIBn4i7klGE9UQ92KtpIubNAiUNXQIv47k=;
        b=aEzfvWfhJfjqwaVDjQ+y2Jj8uQ5QLxM1Z9rSTwdKEVkhpfKq1+Vqx4cQoEo3LUbewb
         nU43G4E5gYmlEqHnYPXnoi+dPlxxjyj2hEDeLmCouA0sk/KCNJqQM5lOtVQx7zd4IeOc
         Nu+R1IfH6LIZkVvQqJ0U2YjQ2u4vWRTNlgJkN4NcOLwYjLzEYcopTqj/2uLvHTnvSQPU
         G6VczY8GZn0HQXUzj2HmCQ64NCkoar+aFuvgFDt+OhG2jMZha7ZvtmNq0lzwD3a6508x
         bjre/yWIfx9smdOvOz6K9HtuVd9grJ7MlUsBVt5ku7kkUWkZ7zoHCriBmFVGGGAb2L31
         6iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sYUDpApbnrIBn4i7klGE9UQ92KtpIubNAiUNXQIv47k=;
        b=cUQiLb+AUMUFfjGRgpb7Smdy8T8FA5/9wDfLlE7Ny+xtnhmsu2Q6n9by2CZxzp5W3/
         pCj6+D25ELP7SpsxR0eyqDPtmUmpZbJZMZuqyMrC18xgnwMbeIHOrCPdXPzN/5pPBjbB
         uwgg6pGS0+8TGvh4hHzh0vWEKyxSQG47X73YiPzYGUuz2wCawj4PbT2pllVsBy6+dOmA
         7I6Hqh6PyRmiXEz9gfm/3QQKj0nIhiJ1g7DZqBTkV6Zvq75bPNLgEgT2fUwX/whcmbVg
         4LXmbQLmaiBFgBTxkk8nOhsJZznLl6yX+vlhhpaaVzuY4qnZfPpZLkgDDsqPdnMHxCHp
         k1Zw==
X-Gm-Message-State: APjAAAVYlc0Az1nhFTbBDmgkx3hEyM/JgNnKFPmKNLm/PHyHgSSZA9GG
        Z7b9JoUH2Ul7rtKRlayksUo=
X-Google-Smtp-Source: APXvYqyNaeJOWDXCKLsONO3xoo0uW5BSwfxZeeqpUW3oEVsmOBAMneaKESWF6GWZ/kvgM7+JkXbHYQ==
X-Received: by 2002:a17:902:290b:: with SMTP id g11mr121725061plb.26.1561020254488;
        Thu, 20 Jun 2019 01:44:14 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id q144sm28994756pfc.103.2019.06.20.01.44.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 01:44:12 -0700 (PDT)
Date:   Thu, 20 Jun 2019 17:44:06 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com
Subject: Re: [PATCH v2 1/5] mm: introduce MADV_COLD
Message-ID: <20190620084406.GE105727@google.com>
References: <20190610111252.239156-1-minchan@kernel.org>
 <20190610111252.239156-2-minchan@kernel.org>
 <20190619125611.GO2968@dhcp22.suse.cz>
 <20190620000650.GB52978@google.com>
 <20190620070854.GC12083@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620070854.GC12083@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 09:08:54AM +0200, Michal Hocko wrote:
> On Thu 20-06-19 09:06:51, Minchan Kim wrote:
> > On Wed, Jun 19, 2019 at 02:56:12PM +0200, Michal Hocko wrote:
> [...]
> > > Why cannot we reuse a large part of that code and differ essentially on
> > > the reclaim target check and action? Have you considered to consolidate
> > > the code to share as much as possible? Maybe that is easier said than
> > > done because the devil is always in details...
> > 
> > Yub, it was not pretty when I tried. Please see last patch in this
> > patchset.
> 
> That is bad because this code is quite subtle - especially the THP part
> of it. I will be staring at the code some more. Maybe some
> simplification pops out.

Yeah, I couldn't come up with better idea. Actually, I wanted to be
left. More suggestion to make simple/readable would be great.
