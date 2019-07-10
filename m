Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F56645F0
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2019 13:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfGJLyF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Jul 2019 07:54:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44906 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfGJLyF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Jul 2019 07:54:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so989186pfe.11;
        Wed, 10 Jul 2019 04:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qFJc4VUzZ7eA+4lKweDf3cU5NLHS16RVicSZWgcgKek=;
        b=gqBRh0w42sxcB+7dw45Xx2hl7SVOoiJ+xuufT+1HnDzjJdfuzBm+yH2jqPyYJQX70Y
         hLRZntmWDekvprvhpBpbQuKBTyAFznaoXdkg+VQL/xAju/jqu+kOtnM2A/0mVV/JntNK
         MBGlw2yxVrEbSCpSHEXnsCdlzcepVEMGKFY1l2IDplLmLFUFNmnkTeLjoYifTBen2GvZ
         Mg9T0f0+sfdtDdSioIpIsg32h+lWoNNe98mVJY/NYg3W3rrMy/TIZ/HQgEgZrSPssiRp
         v9aKccmK4MNGbmrXoX4kSYZEyNnkSHKKqJhWCwBVUasIQmtOpcRAfXmuukPsiOI9cgQK
         TXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFJc4VUzZ7eA+4lKweDf3cU5NLHS16RVicSZWgcgKek=;
        b=lZyPRboNVaHwWjQ8Z+vTy6BOAKzlZbLZWIz2FFJF1YvyaYC/6MsnylyJ3nhPhgosP2
         tXoUcGLFVORpMx93Z9Bvi2en7KWI9n6eAJAd9+jPWdQNu6BqXZRM6F/+OzPKiR7TvjQH
         DcYoUF1w/6WSAOjXvHuqUlw28ijZwad3rEWnUPsf1BUrSoJ5MzfDVXypsWUeGO/Wrwyp
         QE8igkAHA13dKCliBkINmFvqoy1YerDXAZiRzf7KxT2b+RPtuxvV2CapzMIkuMkTXQKF
         ZQX+IUDKrwOIBaYR5oaQ9txMsaNJvKCP8J+VT9IoLZHBw0WUjVcJTdoEXr8uLORZDNyl
         b/FA==
X-Gm-Message-State: APjAAAUn3hFIMAtquBMWVOgVMEa7CJMXl8AvSkIGhV1dIvyoZLVI8xDX
        kv+w4xndIM8SsHMuQ4xXY3g=
X-Google-Smtp-Source: APXvYqxraK6JSVjvhWTndFlIaj5ecwxAEgR9vgrrnmiOU9Tos1QNunQTBS6eWi9kPiiiB1EXmxbYFA==
X-Received: by 2002:a17:90b:8d8:: with SMTP id ds24mr6392025pjb.135.1562759644195;
        Wed, 10 Jul 2019 04:54:04 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id x14sm3012026pfq.158.2019.07.10.04.53.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 04:54:02 -0700 (PDT)
Date:   Wed, 10 Jul 2019 20:53:56 +0900
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
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 4/5] mm: introduce MADV_PAGEOUT
Message-ID: <20190710115356.GC186559@google.com>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627115405.255259-5-minchan@kernel.org>
 <20190709095518.GF26380@dhcp22.suse.cz>
 <20190710104809.GA186559@google.com>
 <20190710111622.GI29695@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710111622.GI29695@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 10, 2019 at 01:16:22PM +0200, Michal Hocko wrote:
> On Wed 10-07-19 19:48:09, Minchan Kim wrote:
> > On Tue, Jul 09, 2019 at 11:55:19AM +0200, Michal Hocko wrote:
> [...]
> > > I am still not convinced about the SWAP_CLUSTER_MAX batching and the
> > > udnerlying OOM argument. Is one pmd worth of pages really an OOM risk?
> > > Sure you can have many invocations in parallel and that would add on
> > > but the same might happen with SWAP_CLUSTER_MAX. So I would just remove
> > > the batching for now and think of it only if we really see this being a
> > > problem for real. Unless you feel really strong about this, of course.
> > 
> > I don't have the number to support SWAP_CLUSTER_MAX batching for hinting
> > operations. However, I wanted to be consistent with other LRU batching
> > logic so that it could affect altogether if someone try to increase
> > SWAP_CLUSTER_MAX which is more efficienty for batching operation, later.
> > (AFAIK, someone tried it a few years ago but rollback soon, I couldn't
> > rebemeber what was the reason at that time, anyway).
> 
> Then please drop this part. It makes the code more complex while any
> benefit is not demonstrated.

The history says the benefit.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/?id=d37dd5dcb955dd8c2cdd4eaef1f15d1b7ecbc379
With the history, rather than proving it's worth for upcoming new code,
need to try to prove no harmful any longer if we want to remove(or not
consistent with other reclaim path). It's not the goal of this patch.
