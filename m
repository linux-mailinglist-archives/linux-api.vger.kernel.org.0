Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E9F1EA7A
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 10:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfEOIwC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 04:52:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39371 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOIwC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 May 2019 04:52:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id w8so1702964wrl.6
        for <linux-api@vger.kernel.org>; Wed, 15 May 2019 01:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F6DFe62CqcWW1zROhCHNbimDkV4rEZq8vvGMAT2Is98=;
        b=ZBTxveOW+mH62CDWQ5jlzur6UHWTmNPWnbakIk2+ANxihT1u4WaSXmDmvoKx4n2UxB
         TK1rbGsLSDsO4rIVaooketF6A43j9HcFheFNTNDlzRjzg/MYNuisEqIUIYFpRgATMFuY
         m2Y2DsLTVGf2s57zckRUG0GOu8f6YW9hcZU4atvNasE6qD8YlPLGk/6jlBgx/HWScEz1
         KQBjYj5Uup/VX+PGMKSgSryostSov2XmBNCOC4XYaZeDwfbcMXkFXl/vdTF897ZN4RGR
         DTI9rqwy/wK4tdVRPXeiYLwEZ0ttCtNpRIgOhBwcQyCJu1gcpNtoOzY7qfzm8+DjB7Wg
         mpCw==
X-Gm-Message-State: APjAAAX0LOWqCF5qyb1RQXuUm4A9KHUtdASPiFXQtzMPvijxAmYrhFsM
        R9oe8Uq99bCEeUgtK/FI6Se0ig==
X-Google-Smtp-Source: APXvYqwLCZxxNevBY2k96AGejabdkmuyTgj3ImDiVQ15+XN1UfSnqKNGvxTjlaeeXG7DlIrNyVO6Ew==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr15326042wrg.89.1557910320163;
        Wed, 15 May 2019 01:52:00 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o16sm1915596wro.63.2019.05.15.01.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 01:51:59 -0700 (PDT)
Date:   Wed, 15 May 2019 10:51:58 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190515085158.hyuamrxkxhjhx6go@butterfly.localdomain>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
 <20190514145122.GG4683@dhcp22.suse.cz>
 <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
 <20190515065311.GB16651@dhcp22.suse.cz>
 <20190515073723.wbr522cpyjfelfav@butterfly.localdomain>
 <20190515083321.GC16651@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515083321.GC16651@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 15, 2019 at 10:33:21AM +0200, Michal Hocko wrote:
> > For my current setup with 2 Firefox instances I get 100 to 200 MiB saved
> > for the second instance depending on the amount of tabs.
> 
> What does prevent Firefox (an opensource project) to be updated to use
> the explicit merging?

This was rather an example of a big project. Other big projects may be
closed source, of course.

And yes, with regard to FF specifically I think nothing prevents it from
being modified appropriately.

> > Answering your question regarding using existing interfaces, since
> > there's only one, madvise(2), this requires modifying all the
> > applications one wants to de-duplicate. In case of containers with
> > arbitrary content or in case of binary-only apps this is pretty hard if
> > not impossible to do properly.
> 
> OK, this makes more sense. Please note that there are other people who
> would like to see certain madvise operations to be done on a remote
> process - e.g. to allow external memory management (Android would like
> to control memory aging so something like MADV_DONTNEED without loosing
> content and more probably) and potentially other madvise operations.
> Or maybe we need a completely new interface other than madvise.

I didn't know about those intentions. Could you please point me to a
relevant discussion so that I can check the details?

> In general, having a more generic API that would cover more usecases is
> definitely much more preferable than one ad-hoc API that handles a very
> specific usecase. So please try to think about a more generic

Yup, I see now. Since you are aware of ongoing intentions, please do Cc
those people then and/or let me know about previous discussions please.
That way thinking of how a new API should be implemented (be it a sysfs
file or something else) should be easier and more visible.

Thanks.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
