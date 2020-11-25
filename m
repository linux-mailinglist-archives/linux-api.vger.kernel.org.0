Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C812C4BAF
	for <lists+linux-api@lfdr.de>; Thu, 26 Nov 2020 00:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgKYXn1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Nov 2020 18:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgKYXn0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Nov 2020 18:43:26 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB44AC0613D4;
        Wed, 25 Nov 2020 15:43:26 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m9so123483pgb.4;
        Wed, 25 Nov 2020 15:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bQYnjhL0stRqsuyZnoj4uO3ieagz/79UtzcnmbDad6s=;
        b=g9BQfhCoDg8rHX2/STPOQSCULFMxCVHtLH+m7w2TQC+3YZLzjBdtDSx5hSmNUHH2BM
         ViQQ9ovPWt2dCOE6blxmwtXDQLyJWhHThOLDxC02yakybbfpZ4Nvgtit5PpOk9Kzgm0+
         NZrv4z6wcNuCFxFedO8YWTNmCnSL2q147J+v6SVu576fgd4QllvLDr4efTKnGjna0vCE
         fMiePrg1EC2xjjSiDPsh4SLFllZ2xj0uEoipp7T40z/LzO8NgwY1BT6r3u1SVd+7/vTx
         7im50bf/847dbrNh81Z1J8YXTX44lAMzknn162Yp9j8eqbwrz01c7i/mmp1MG2rcJovE
         b2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bQYnjhL0stRqsuyZnoj4uO3ieagz/79UtzcnmbDad6s=;
        b=AF94pH3Nl/xtdkNusk332di2Zv5LLBPMAi/8BLjxmqZqUSfj0uX8Qn0aFIlOWn3L7q
         /XxFMXExWBM1UZ2mlyWNRz5CWyhhTcJvUh37/Spm21m7pC8OylTNzfbL7rYbYIk1hNVL
         9BatE4M8YXqEvq9ac2/LYWxd8IzcPBzNsiW9NKdzuvjGahdZ+P+sSBK5FD3CdvMhWB/S
         qny4M7m/NgsTrxJkmW6MlKvtVKG6R+YwIprv2uSVwlpPBJgEPskrpRU196x1i40PCzPd
         6iOS2+1QO3R+AlLDj7Vik9LZg4Zukmno2HzEFbBQqvslob9PTlbOiIPWk43WM1hi6PQa
         zulQ==
X-Gm-Message-State: AOAM533A7hF28XwgAukzXR87YY9JNn/cA/zpb+tSGK4WulqWhoXd2jFZ
        6aZjqF19DmdC8QCENoB8MnA=
X-Google-Smtp-Source: ABdhPJx6wng91PMAdMoNOKNRWJ5AbARmgJMXsqWGoOyveeV0KdmGQvix9JhD+VHflR2ilSZgYUi8eQ==
X-Received: by 2002:a17:90a:fe88:: with SMTP id co8mr241177pjb.76.1606347806124;
        Wed, 25 Nov 2020 15:43:26 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id y20sm2866194pfr.159.2020.11.25.15.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 15:43:25 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 25 Nov 2020 15:43:22 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm/madvise: allow process_madvise operations on
 entire memory range
Message-ID: <20201125234322.GG1484898@google.com>
References: <20201124053943.1684874-1-surenb@google.com>
 <20201124053943.1684874-2-surenb@google.com>
 <20201125231322.GF1484898@google.com>
 <CAJuCfpGCc49g5+T+V3SxZ6eVteLac6xVRx+1z6G2a8P4-Cr7bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGCc49g5+T+V3SxZ6eVteLac6xVRx+1z6G2a8P4-Cr7bA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 25, 2020 at 03:23:40PM -0800, Suren Baghdasaryan wrote:
> On Wed, Nov 25, 2020 at 3:13 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Mon, Nov 23, 2020 at 09:39:42PM -0800, Suren Baghdasaryan wrote:
> > > process_madvise requires a vector of address ranges to be provided for
> > > its operations. When an advice should be applied to the entire process,
> > > the caller process has to obtain the list of VMAs of the target process
> > > by reading the /proc/pid/maps or some other way. The cost of this
> > > operation grows linearly with increasing number of VMAs in the target
> > > process. Even constructing the input vector can be non-trivial when
> > > target process has several thousands of VMAs and the syscall is being
> > > issued during high memory pressure period when new allocations for such
> > > a vector would only worsen the situation.
> > > In the case when advice is being applied to the entire memory space of
> > > the target process, this creates an extra overhead.
> > > Add PMADV_FLAG_RANGE flag for process_madvise enabling the caller to
> > > advise a memory range of the target process. For now, to keep it simple,
> > > only the entire process memory range is supported, vec and vlen inputs
> > > in this mode are ignored and can be NULL and 0.
> > > Instead of returning the number of bytes that advice was successfully
> > > applied to, the syscall in this mode returns 0 on success. This is due
> > > to the fact that the number of bytes would not be useful for the caller
> > > that does not know the amount of memory the call is supposed to affect.
> > > Besides, the ssize_t return type can be too small to hold the number of
> > > bytes affected when the operation is applied to a large memory range.
> >
> > Can we just use one element in iovec to indicate entire address rather
> > than using up the reserved flags?
> >
> >         struct iovec {
> >                 .iov_base = NULL,
> >                 .iov_len = (~(size_t)0),
> >         };
> >
> > Furthermore, it would be applied for other syscalls where have support
> > iovec if we agree on it.
> >
> 
> The flag also changes the return value semantics. If we follow your
> suggestion we should also agree that in this mode the return value
> will be 0 on success and negative otherwise instead of the number of
> bytes madvise was applied to.

Well, return value will depends on the each API. If the operation is
desruptive, it should return the right size affected by the API but
would be okay with 0 or error, otherwise.
