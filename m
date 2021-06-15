Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F7A3A88AB
	for <lists+linux-api@lfdr.de>; Tue, 15 Jun 2021 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhFOSgO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 15 Jun 2021 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhFOSgO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 Jun 2021 14:36:14 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E61C0617AF
        for <linux-api@vger.kernel.org>; Tue, 15 Jun 2021 11:34:08 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id k9so157319qvu.13
        for <linux-api@vger.kernel.org>; Tue, 15 Jun 2021 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ci8pTDsI4+1dl8hd8DPpx4lfE/2PNymYi+7s+L/rCno=;
        b=PK99xqIi4vOJCiwjyFx7sp/rvE4QciQ9VOYWadYlda8ip8BShy10QYGLAjNTlX6yj4
         NpuPKMftibD60GvE085PX/7Drph1xMAHMwToXAmI5pJhp1P0RgnZCkkOHwQ3/vJaU+1W
         ctUknv+wA4Cnp1nbxaQurmpCYJZtTHdtSBrJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ci8pTDsI4+1dl8hd8DPpx4lfE/2PNymYi+7s+L/rCno=;
        b=d4z14X5NWFIfOPbdcWqOJJIWN7YqHIYK3qiBrGsxodtjV43GvMxjhnCwf0rp6FvWRn
         seQySsi+uSn7QdpOl4CrOn+UZR7oHsLIVLFwZ05xMoPXlzCIx6LNAhVx/RduVxV6RddP
         EAJlZGC34AdEmHgQIlXxUdJpRdNte8UaTtzvvNqr0Or1tm7nj3oe8Tfn7JApQ2rekcQ/
         VsIJapKSV+qT9Z3OH5KZUFKEC9HGPUFchjhFbIbslT4r/wdOFsn5g92NKB9NNhpO4clM
         yytZ/6oYC+yQ7ZrVDSLU84udE9zCH2GkCqRotKCqZ/4jfVj9xmjqgH6gE80xwVeAGO4c
         KhLg==
X-Gm-Message-State: AOAM532WGXysODrjHG0s3o5pHxPONtWMpPhjlBkKtRC0FoyOYMyxVKqj
        arm7FKi5nb5qmYDu4I08XZHj6A==
X-Google-Smtp-Source: ABdhPJyHWGn07W9hcHEIH999jGrYf+wW2jw6aRdNw2u5boIr2c5TmIFSEKWlZQrl7KeRgxw5C3vtRg==
X-Received: by 2002:a0c:e8cd:: with SMTP id m13mr6841876qvo.52.1623782047319;
        Tue, 15 Jun 2021 11:34:07 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id g24sm11940010qts.60.2021.06.15.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:34:06 -0700 (PDT)
Date:   Tue, 15 Jun 2021 14:34:05 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg KH <greg@kroah.com>, Christoph Lameter <cl@gentwo.de>,
        Theodore Ts'o <tytso@mit.edu>, Jiri Kosina <jikos@kernel.org>,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Maintainers / Kernel Summit 2021 planning kick-off
Message-ID: <20210615183405.rchiaaybuhx244qa@nitro.local>
References: <YLEIKk7IuWu6W4Sy@casper.infradead.org>
 <YH2hs6EsPTpDAqXc@mit.edu>
 <nycvar.YFH.7.76.2104281228350.18270@cbobk.fhfr.pm>
 <YIx7R6tmcRRCl/az@mit.edu>
 <alpine.DEB.2.22.394.2105271522320.172088@gentwo.de>
 <YK+esqGjKaPb+b/Q@kroah.com>
 <c46dbda64558ab884af060f405e3f067112b9c8a.camel@HansenPartnership.com>
 <1745326.1623409807@warthog.procyon.org.uk>
 <e47706ee-3e4b-8f15-963f-292b5e47cb1d@metux.net>
 <YMjxqEY25A6bm47s@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMjxqEY25A6bm47s@casper.infradead.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 15, 2021 at 07:30:00PM +0100, Matthew Wilcox wrote:
> > Wouldn't just taking prophylatic meds like CDS or HCQ and/or hi-dose
> > vitamins (C, D3+K2) be way more cost effective and flexible than to
> > charter a whole plane ?
> 
> Why don't you just shine a bright light up your arse?  It'll have the
> same effect.

Please stop.

I do not have ability to ban people across all cc'd lists, but I will for sure
start adding people to block filters on the infra to which I have access if
this wildly off-topic discussion continues and especially if things continue
to deteriorate into name-calling.

-K
