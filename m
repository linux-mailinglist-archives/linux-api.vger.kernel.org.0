Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D03D110515F
	for <lists+linux-api@lfdr.de>; Thu, 21 Nov 2019 12:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKUL1a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Nov 2019 06:27:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48327 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfKUL1a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Nov 2019 06:27:30 -0500
Received: from [79.140.122.151] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iXkcL-0005p8-6z; Thu, 21 Nov 2019 11:27:21 +0000
Date:   Thu, 21 Nov 2019 12:27:20 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>, adrian@lisas.de,
        akpm@linux-foundation.org, arnd@arndb.de, avagin@gmail.com,
        dhowells@redhat.com, fweimer@redhat.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        mingo@elte.hu, oleg@redhat.com, xemul@virtuozzo.com
Subject: Re: [PATCH] clone.2: Mention that CLONE_PARENT is off-limits for
 inits
Message-ID: <20191121112719.lg3qxptnowjkpxlg@wittgenstein>
References: <20191120104504.22411-1-christian@brauner.io>
 <ac6c1644-c6d3-c7eb-48b1-28eb9342a468@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac6c1644-c6d3-c7eb-48b1-28eb9342a468@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 21, 2019 at 10:53:50AM +0100, Michael Kerrisk (man-pages) wrote:
> Hello Christian,
> 
> On 11/20/19 11:45 AM, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > The CLONE_PARENT flag cannot but used by init processes. Let's mention
> > this in the manpages to prevent suprises.
> > 
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  man2/clone.2 | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/man2/clone.2 b/man2/clone.2
> > index f0f29d6f1..aa98ab79b 100644
> > --- a/man2/clone.2
> > +++ b/man2/clone.2
> > @@ -646,6 +646,13 @@ if
> >  .B CLONE_PARENT
> >  is set, then the parent of the calling process, rather than the
> >  calling process itself, will be signaled.
> > +.IP
> > +The kernel will not allow global init and init processes in pid
> > +namespaces to use the
> > +.B CLONE_PARENT
> > +flag. This is done to prevent the creation of multi-rooted process
> > +trees. It also avoids unreapable zombies in the initial pid
> > +namespace.
> >  .TP
> >  .BR CLONE_PARENT_SETTID " (since Linux 2.5.49)"
> >  Store the child thread ID at the location pointed to by
> 
> Thank. I applied, and then tweaked the text a little,
> and noted the associated EINVAL error. In the end, the
> change is as below.

Thanks!
Christian
