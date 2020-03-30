Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA021984FE
	for <lists+linux-api@lfdr.de>; Mon, 30 Mar 2020 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgC3Tzw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Mar 2020 15:55:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40509 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbgC3Tzr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Mar 2020 15:55:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id w26so22285187edu.7
        for <linux-api@vger.kernel.org>; Mon, 30 Mar 2020 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dh9JcSi6kj0UWIbirpsquHk1PO2ZTJ6f6wAxTa4W5Zs=;
        b=DZk2EcadSRy+jmjLIyyvOwCfhNdDlY3wMU3gTOTK1MOXJ9bZhFpym+h6ycl+idnIWn
         SsmZQJKtl9iTffn/DdsGsPysGCoyWM9UFc0uMIYHqOT2z5sBnbcDqL176yFWOcNWpk/v
         SL53a/gXGohE1DQca/J8rKY+wKFfgrlpBcJTWgpRRmqX4D4/lPWy9aotUaYsxCYmYiYK
         OtSNHNlZDTpDF0dFONn3fKYVj/3RoQP8vPxJqI1/s4VGJN+h5iwuRg6I0xGMy9Xnyver
         +2Vt0W54SbaK/bs9jzOVTjHv/eCoKKiYgbHkxhUe93AIoeTE2uwNruCrN5QeGM0qgjOo
         zdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dh9JcSi6kj0UWIbirpsquHk1PO2ZTJ6f6wAxTa4W5Zs=;
        b=Za2kMdezJ7vKg2k/h6X2qtaUYujPsPA0ML/Ex4WgXJoKc0jxEOfSvNI856WIco5Gpg
         dxpXA3YHq0LOBbXk4dxvfWb/tRX0l3M0y4IawbGS+uhURM0vUy7Yd/La/DMmynbnxiG5
         JOuy8LZrDbKDdXATB6hkhfFvmr1F1ptx5HrBpOSQLhnuo6TZKKeGLJMdBkgqgFO1dl8H
         T0WGouCSizHU2ZcZr7EKGUH3pTItdV+fG5nbu9RB+vpO5FXvMUu8UgI+E2QeN9PzRVzz
         N40zgqjzsdatirBM0cNeX8HPBI7ZdcM/MaQIp2eL/FUqTckADjUkPfWdNaJj3RGzVREp
         wq+Q==
X-Gm-Message-State: ANhLgQ1VzJ2IxPxA+BVaCJ2ZueRZuZ/dNLz6bzHUiPlLp/j3uEb2QuGe
        ZCjyVHtamsrvVaMXZWWRmxhJKh3qLyUpLTXzkRXG
X-Google-Smtp-Source: ADFU+vul3dd78FpyQ/P1xT0CAzUKDA49PHsMIvhi1CMzemU48YH7Min2sbynkoDLmBburfXlTyDJdiTLpwO7v8ADPZw=
X-Received: by 2002:a50:f152:: with SMTP id z18mr12867397edl.31.1585598145722;
 Mon, 30 Mar 2020 12:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200318215550.es4stkjwnefrfen2@madcap2.tricolour.ca>
 <CAHC9VhSdDDP7Ec-w61NhGxZG5ZiekmrBCAg=Y=VJvEZcgQh46g@mail.gmail.com>
 <20200319220249.jyr6xmwvflya5mks@madcap2.tricolour.ca> <CAHC9VhR84aN72yNB_j61zZgrQV1y6yvrBLNY7jp7BqQiEDL+cw@mail.gmail.com>
 <20200324210152.5uydf3zqi3dwshfu@madcap2.tricolour.ca> <CAHC9VhTQUnVhoN3JXTAQ7ti+nNLfGNVXhT6D-GYJRSpJHCwDRg@mail.gmail.com>
 <20200330134705.jlrkoiqpgjh3rvoh@madcap2.tricolour.ca> <CAHC9VhQTsEMcYAF1CSHrrVn07DR450W9j6sFVfKAQZ0VpheOfw@mail.gmail.com>
 <20200330162156.mzh2tsnovngudlx2@madcap2.tricolour.ca> <CAHC9VhTRzZXJ6yUFL+xZWHNWZFTyiizBK12ntrcSwmgmySbkWw@mail.gmail.com>
 <20200330174937.xalrsiev7q3yxsx2@madcap2.tricolour.ca>
In-Reply-To: <20200330174937.xalrsiev7q3yxsx2@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Mar 2020 15:55:36 -0400
Message-ID: <CAHC9VhR_bKSHDn2WAUgkquu+COwZUanc0RV3GRjMDvpoJ5krjQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        linux-audit@redhat.com, netfilter-devel@vger.kernel.org,
        ebiederm@xmission.com, simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 30, 2020 at 1:49 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-03-30 13:34, Paul Moore wrote:
> > On Mon, Mar 30, 2020 at 12:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2020-03-30 10:26, Paul Moore wrote:
> > > > On Mon, Mar 30, 2020 at 9:47 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > On 2020-03-28 23:11, Paul Moore wrote:
> > > > > > On Tue, Mar 24, 2020 at 5:02 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > > On 2020-03-23 20:16, Paul Moore wrote:
> > > > > > > > On Thu, Mar 19, 2020 at 6:03 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > > > > On 2020-03-18 18:06, Paul Moore wrote:

...

> > > Well, every time a record gets generated, *any* record gets generated,
> > > we'll need to check for which audit daemons this record is in scope and
> > > generate a different one for each depending on the content and whether
> > > or not the content is influenced by the scope.
> >
> > That's the problem right there - we don't want to have to generate a
> > unique record for *each* auditd on *every* record.  That is a recipe
> > for disaster.
>
> I don't see how we can get around this.
>
> We will already have that problem for PIDs in different PID namespaces.

As I said below, let's not worry about this for all of the
known/current audit records, lets just think about how we solve this
for the ACID related information.

One of the bigger problems with translating namespace info (e.g. PIDs)
across ACIDs is that an ACID - by definition - has no understanding of
namespaces (both the concept as well as any given instance).

> We already need to use a different serial number in each auditd/queue,
> or else we serialize *all* audit events on the machine and either leak
> information to the nested daemons that there are other events happenning
> on the machine, or confuse the host daemon because it now thinks that we
> are losing events due to serial numbers missing because some nested
> daemon issued an event that was not relevant to the host daemon,
> consuming a globally serial audit message sequence number.

This isn't really relevant to the ACID lists, but sure.

> > Solving this for all of the known audit records is not something we
> > need to worry about in depth at the moment (although giving it some
> > casual thought is not a bad thing), but solving this for the audit
> > container ID information *is* something we need to worry about right
> > now.
>
> If you think that a different nested contid value string per daemon is
> not acceptable, then we are back to issuing a record that has only *one*
> contid listed without any nesting information.  This brings us back to
> the original problem of keeping *all* audit log history since the boot
> of the machine to be able to track the nesting of any particular contid.

I'm not ruling anything out, except for the "let's just completely
regenerate every record for each auditd instance".

> What am I missing?  What do you suggest?

I'm missing a solution in this thread, since you are the person
driving this effort I'm asking you to get creative and present us with
some solutions. :)


-- 
paul moore
www.paul-moore.com
