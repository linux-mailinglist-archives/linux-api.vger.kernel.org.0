Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEAC2FDF4
	for <lists+linux-api@lfdr.de>; Thu, 30 May 2019 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfE3OfH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 May 2019 10:35:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44454 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfE3OfD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 May 2019 10:35:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so5198287lfm.11
        for <linux-api@vger.kernel.org>; Thu, 30 May 2019 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnDbzkkNEs3+qCAYM6PlcBSJ9muruAbc6zh0yrmMscI=;
        b=GWJCSp8Ea5nLSw4PQsmUexLPU9ilEqisyppKzq55gGe0EXTU1gK81I2OupZcNpEfBp
         FEt6cP3ID92EWi+7AOnBYGA0Ks7kMMHmIwuCOXSTnoWyt9G0QUg/qPKTyCr++U1Vj81z
         OBD9bVbRccfpHrJSutlT+QxN7HGtO6iu7CDa5SLnoPR89ac3mi2LAiNOoxPv0PDN/hp4
         l40+0DaiA/QQzBIUYu0FZHnaSsQni3VmtD1j1Ni4uJrquQC2ecy5KN+HQxdP9IoLrIqB
         NQaPK9NrzK6KSr1mQCUVyOMXunHba1wxDCzenzD+grV8InLlZw+DV7yqW3qc0uFM5f2z
         aTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnDbzkkNEs3+qCAYM6PlcBSJ9muruAbc6zh0yrmMscI=;
        b=bBaUQXGn2V3ObNIU76PdsFjc1OIgjOb5bTlxV3iHJq1BEWvRM1eb+JyjemI5Ilhaml
         a9OljsMRsV4ApCLpKWCqONqXH82sYXuvRX0nEnZiAV3q1N/lihT4QObnDTcLGJZUPBsi
         LtDP4MBzX5lPp4orYREIrT16FzdAGABY7rezDEiwYZZ93eRHM+axde9vXe0wz2tPmoUK
         +xrCi/yInoKiMmVzEd5fZ6WPSRO1GVKEpVv9YCic4STppQ1LYRq5YF54sqp9XwitXqMO
         QtBGWsBYsn4BmFoOPjTgSGQ0ZrBy4b3qMjsWGDTH7deTojzYOxNpElpG/l0GECDsJCn0
         UadQ==
X-Gm-Message-State: APjAAAXZ7GEPKfxBBUyx54V6xx0EHSel4EmKSGPOXTVNupfjUhL6tRHO
        jlvKYsJJZB4ndKLWe9k95Sa46JwKHGT6XChJmDVd
X-Google-Smtp-Source: APXvYqwHC8RbjMH6lxvVIhsAzDm3HE9/Eadxhwf+Gs4Sub/2cYfUPJHXYxbbG9TWyQTvzlhVlUcV6s1iN4J/NfvvlRg=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr2250887lfi.175.1559226900658;
 Thu, 30 May 2019 07:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554732921.git.rgb@redhat.com> <0785ee2644804f3ec6af1243cc0dcf89709c1fd4.1554732921.git.rgb@redhat.com>
 <CAHC9VhRV-0LSEcRvPO1uXtKdpEQsaLZnBV3T=zcMTZPN5ugz5w@mail.gmail.com> <20190530141951.iofimovrndap4npq@madcap2.tricolour.ca>
In-Reply-To: <20190530141951.iofimovrndap4npq@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 May 2019 10:34:49 -0400
Message-ID: <CAHC9VhQhkzCtVOXhPL7BzaqvF0y+8gBQwhOo1EQDS2OUyZbV5g@mail.gmail.com>
Subject: Re: [PATCH ghak90 V6 08/10] audit: add containerid filtering
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 30, 2019 at 10:20 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> On 2019-05-29 18:16, Paul Moore wrote:
> > On Mon, Apr 8, 2019 at 11:41 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > Implement audit container identifier filtering using the AUDIT_CONTID
> > > field name to send an 8-character string representing a u64 since the
> > > value field is only u32.
> > >
> > > Sending it as two u32 was considered, but gathering and comparing two
> > > fields was more complex.
> > >
> > > The feature indicator is AUDIT_FEATURE_BITMAP_CONTAINERID.
> > >
> > > Please see the github audit kernel issue for the contid filter feature:
> > >   https://github.com/linux-audit/audit-kernel/issues/91
> > > Please see the github audit userspace issue for filter additions:
> > >   https://github.com/linux-audit/audit-userspace/issues/40
> > > Please see the github audit testsuiite issue for the test case:
> > >   https://github.com/linux-audit/audit-testsuite/issues/64
> > > Please see the github audit wiki for the feature overview:
> > >   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > Acked-by: Serge Hallyn <serge@hallyn.com>
> > > Acked-by: Neil Horman <nhorman@tuxdriver.com>
> > > Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  include/linux/audit.h      |  1 +
> > >  include/uapi/linux/audit.h |  5 ++++-
> > >  kernel/audit.h             |  1 +
> > >  kernel/auditfilter.c       | 47 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  kernel/auditsc.c           |  4 ++++
> > >  5 files changed, 57 insertions(+), 1 deletion(-)
> >
> > ...
> >
> > > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > > index 63f8b3f26fab..407b5bb3b4c6 100644
> > > --- a/kernel/auditfilter.c
> > > +++ b/kernel/auditfilter.c
> > > @@ -1206,6 +1224,31 @@ int audit_comparator(u32 left, u32 op, u32 right)
> > >         }
> > >  }
> > >
> > > +int audit_comparator64(u64 left, u32 op, u64 right)
> > > +{
> > > +       switch (op) {
> > > +       case Audit_equal:
> > > +               return (left == right);
> > > +       case Audit_not_equal:
> > > +               return (left != right);
> > > +       case Audit_lt:
> > > +               return (left < right);
> > > +       case Audit_le:
> > > +               return (left <= right);
> > > +       case Audit_gt:
> > > +               return (left > right);
> > > +       case Audit_ge:
> > > +               return (left >= right);
> > > +       case Audit_bitmask:
> > > +               return (left & right);
> > > +       case Audit_bittest:
> > > +               return ((left & right) == right);
> > > +       default:
> > > +               BUG();
> >
> > A little birdy mentioned the BUG() here as a potential issue and while
> > I had ignored it in earlier patches because this is likely a
> > cut-n-paste from another audit comparator function, I took a closer
> > look this time.  It appears as though we will never have an invalid op
> > value as audit_data_to_entry()/audit_to_op() ensure that the op value
> > is a a known good value.  Removing the BUG() from all the audit
> > comparators is a separate issue, but I think it would be good to
> > remove it from this newly added comparator; keeping it so that we
> > return "0" in the default case seems reasoanble.
>
> Fair enough.  That BUG(); can be removed.

Please send a fixup patch for this.

-- 
paul moore
www.paul-moore.com
