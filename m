Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D445C4FEB5
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 03:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfFXBw2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 23 Jun 2019 21:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbfFXBw2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 23 Jun 2019 21:52:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB2E6C04959F;
        Mon, 24 Jun 2019 01:52:23 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A55310018F9;
        Mon, 24 Jun 2019 01:52:14 +0000 (UTC)
Date:   Mon, 24 Jun 2019 09:52:06 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     James Morris <jmorris@namei.org>, Jiri Bohac <jbohac@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
Message-ID: <20190624015206.GB2976@dhcp-128-65.nay.redhat.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com>
 <20190621064340.GB4528@localhost.localdomain>
 <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 24 Jun 2019 01:52:28 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 06/21/19 at 01:18pm, Matthew Garrett wrote:
> On Thu, Jun 20, 2019 at 11:43 PM Dave Young <dyoung@redhat.com> wrote:
> >
> > On 03/26/19 at 11:27am, Matthew Garrett wrote:
> > > From: Jiri Bohac <jbohac@suse.cz>
> > >
> > > When KEXEC_SIG is not enabled, kernel should not load images through
> > > kexec_file systemcall if the kernel is locked down.
> > >
> > > [Modified by David Howells to fit with modifications to the previous patch
> > >  and to return -EPERM if the kernel is locked down for consistency with
> > >  other lockdowns. Modified by Matthew Garrett to remove the IMA
> > >  integration, which will be replaced by integrating with the IMA
> > >  architecture policy patches.]
> > >
> > > Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > > Reviewed-by: Jiri Bohac <jbohac@suse.cz>
> > > cc: kexec@lists.infradead.org
> > > ---
> > >  kernel/kexec_file.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 67f3a866eabe..a1cc37c8b43b 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> > >               }
> > >
> > >               ret = 0;
> > > +
> > > +             if (kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)) {
> > > +                     ret = -EPERM;
> > > +                     goto out;
> > > +             }
> > > +
> >
> > Checking here is late, it would be good to move the check to earlier
> > code around below code:
> >         /* We only trust the superuser with rebooting the system. */
> >         if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> >                 return -EPERM;
> 
> I don't think so - we want it to be possible to load images if they
> have a valid signature.

I know it works like this way because of the previous patch.  But from
the patch log "When KEXEC_SIG is not enabled, kernel should not load
images", it is simple to check it early for !IS_ENABLED(CONFIG_KEXEC_SIG) && 
kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)  instead of depending
on the late code to verify signature.  In that way, easier to
understand the logic, no?

Thanks
Dave
