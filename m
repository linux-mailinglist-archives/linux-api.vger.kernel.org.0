Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCF2A56FA
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 22:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbgKCVcg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Nov 2020 16:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbgKCVcd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Nov 2020 16:32:33 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51737C0613D1;
        Tue,  3 Nov 2020 13:32:33 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p4so1879282plr.1;
        Tue, 03 Nov 2020 13:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Rflj5FeVFQvvR71X1g+Z0EkePu6R/sIbeOUdmV31Zo=;
        b=SM5hm/s/rUbBqvOtec7WpIsvEOMJPkG934FXjlJcEmBErrV8eJeFro3qH2XeaSIzZy
         vN6NJlmKIWtxmUfYzOWd6k36JMaF/+tRiMDavvHwJlYQvvtyJQzNo4WMp3RSmR1xSGwY
         rSTkSeyQeId5RJaJS1LCnpo134QaLxaYNvv1RqScfZFO0kkHebOHk+6gosud/2dzZEer
         nldUB9sQt32LyCSeC5Dd+bwYHUpzqGXRfHbk6W8hXYc3nGw/ANWmO6h6LnBumcLVAgon
         /OZB2GUSWXzAwz/qL9wOS1WGPtO/wnulhCS2HfhNr1U9noCdzBTDCRdqBLTqIATtdxLc
         UlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0Rflj5FeVFQvvR71X1g+Z0EkePu6R/sIbeOUdmV31Zo=;
        b=BanFM4P0+zvHr7hYDg09Sc/Ia+w3IFNOBaTfs3/fn+ox2G0RCffyj+bcqsacZCofxR
         m642saJuyKsmZZoUyRXlVlBXbaQlrDBO/iNmZQnM58hN024VqtT3FHniUc393squSX79
         KUidpShc9h6eLIqXDHu7fW9LKVLIPL1pCTkoRhQLtafQXSzcy2hm1OfU9g2FbAKsx0oB
         i5JSMVCpskvej2x/Ls0yvCRF/Dlr9JWEW3MyJitNXiUOCo3AxsQvPhYdtxSMGCRQcuu/
         W4AlPCnjnwl9OzwFu5/7u7hiKfKLqakiYm/UFhiOrvSTaRN7ESf9mJ7cQJDRVYrHECTe
         +tvQ==
X-Gm-Message-State: AOAM530klED2bEnlp7+KJnhm1cc64yxGRhbD9Q1vwizfEaUzkcCFfQ6K
        vvYaMzAn+NaqQub5NMxHE3c=
X-Google-Smtp-Source: ABdhPJxfymqYguZC9tMMm4xPTSJq8KyM1kPmTukDkHGwybfrB40JI6+eLDF4l0XvD9SuZiCqxA26YA==
X-Received: by 2002:a17:902:aa97:b029:d5:ac09:c5ec with SMTP id d23-20020a170902aa97b02900d5ac09c5ecmr26100575plr.78.1604439152426;
        Tue, 03 Nov 2020 13:32:32 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id a10sm91190pjq.17.2020.11.03.13.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 13:32:31 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 3 Nov 2020 13:32:28 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC]: userspace memory reaping
Message-ID: <20201103213228.GB1631979@google.com>
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz>
 <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz>
 <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103093550.GE21990@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> [...]
> > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > which in addition to sending a kill signal would also reap the
> > victim's mm in the context of the caller? Maybe having some code will
> > get the discussion moving forward?
> 
> Yeah, having a code, even preliminary, might help here. This definitely
> needs a good to go from process management people as that proper is land
> full of surprises...

Just to remind a idea I suggested to reuse existing concept

    fd = pidfd_open(victim process)
    fdatasync(fd);
    close(fd);

