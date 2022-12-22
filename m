Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278A26547B9
	for <lists+linux-api@lfdr.de>; Thu, 22 Dec 2022 22:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiLVVRM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Dec 2022 16:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiLVVRL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Dec 2022 16:17:11 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82520B1D8
        for <linux-api@vger.kernel.org>; Thu, 22 Dec 2022 13:17:10 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f9so2113271pgf.7
        for <linux-api@vger.kernel.org>; Thu, 22 Dec 2022 13:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DKGYCzvkrRQsG26exGSDsGM12AW8tkADFj8h5RB+A30=;
        b=xA2sAcbvHRLRPTNUcWhOU2eTVgIGKrEnm3k5rs25we3/mQswqEnKJE0BAFGpg2kPLM
         Dn+EN3WwOtSdz1LqYVQHtlzMiwaek22Q1ndUd9meDVwMakC3sKgEbMO0Rc8qgFYrbgtk
         4w2iEeXUEjqhaSrsFJcAuejShPMBEUqXlFZ9Kfn/61Me0fPEwNYwlDC6fmLNoUU1VAgz
         aNA638ly+YP1vGWFb1l37EDPbImpC/e4Vi1aHts4gCQHLljJG37sLlLDYxqYZCqJq/w6
         EBu1T8DMU/uOOsK8JeW7wGifHMMCwARYXQq6U9qR4aEosFifxbJqR7YbwEd7Ib/oBOds
         A1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKGYCzvkrRQsG26exGSDsGM12AW8tkADFj8h5RB+A30=;
        b=w7GOQKEoQJBO3dpeOV4z2B597kfTrBsy6Lvi9Y57L9ZknJINIbEPiCOTmWBrhcNsf8
         h+L/ytz1s73ES0k/fHUZMmlX65Sw77UZiAF/naaZxvKwaREu9vVlmt73+GZESoo1iUT3
         spGiMxNRQetMJjX+Kp14lvN4xqwQouNhmoaRSxxIr9SSKB6zV0Jh6PJ0cEP+ids/UXMw
         WmA2pryVoFl/FhFiEt5cF5PYPGkN7P1a6CRw7CGRC/xJDILLgFk8BbdsAf4h9THQq6Up
         ieTsoY8VHmnCHQGASq5uSoufsSRwI7t5YpAVEahgnNqf1vvtCGvNZGHuuwLpiwthI08C
         YQqw==
X-Gm-Message-State: AFqh2kpqvVn40NIMgNK3pgFBKomqq6DHMXu4sHlD6zshLirqUH/p65bU
        cuMj5iWW2IfctE0XNeNr7vgUkQtUw94BNZPQJcXwiK1lo0EH
X-Google-Smtp-Source: AMrXdXutQGBOBCQtEo6BWJnU2LinVPQY1YK1lmJoTJgmHaEQzUCCjkTLfrnDcRjCZNzga7g8tnUcuDgqK3DL5+HgtFo=
X-Received: by 2002:aa7:924d:0:b0:577:62a8:f7a1 with SMTP id
 13-20020aa7924d000000b0057762a8f7a1mr454916pfp.2.1671743829956; Thu, 22 Dec
 2022 13:17:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670606054.git.rgb@redhat.com> <79fcf72ea442eeede53ed5e6de567f8df8ef7d83.1670606054.git.rgb@redhat.com>
 <CAHC9VhQont7=S9pvTpLUmxVSj-g-j2ZhVCLiUki69vtp8rf-9A@mail.gmail.com> <Y6TBL7+W7Q1lYc9Q@madcap2.tricolour.ca>
In-Reply-To: <Y6TBL7+W7Q1lYc9Q@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Dec 2022 16:16:58 -0500
Message-ID: <CAHC9VhQ6Nn2DuO-w3OtMj3rrtPp+X5ULYpZW8wLTakK9sMrs0g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] fanotify,audit: Allow audit to use the full
 permission event response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-api@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Dec 22, 2022 at 3:42 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2022-12-20 18:31, Paul Moore wrote:
> > On Mon, Dec 12, 2022 at 9:06 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > This patch passes the full response so that the audit function can use all
> > > of it. The audit function was updated to log the additional information in
> > > the AUDIT_FANOTIFY record.
> > >
> > > Currently the only type of fanotify info that is defined is an audit
> > > rule number, but convert it to hex encoding to future-proof the field.
> > > Hex encoding suggested by Paul Moore <paul@paul-moore.com>.
> > >
> > > Sample records:
> > >   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3137 subj_trust=3 obj_trust=5
> > >   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F subj_trust=2 obj_trust=2
> > >
> > > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > > Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  fs/notify/fanotify/fanotify.c |  3 ++-
> > >  include/linux/audit.h         |  9 +++++----
> > >  kernel/auditsc.c              | 25 ++++++++++++++++++++++---
> > >  3 files changed, 29 insertions(+), 8 deletions(-)
> >
> > ...
> >
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index d1fb821de104..8d523066d81f 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -64,6 +64,7 @@
> > >  #include <uapi/linux/limits.h>
> > >  #include <uapi/linux/netfilter/nf_tables.h>
> > >  #include <uapi/linux/openat2.h> // struct open_how
> > > +#include <uapi/linux/fanotify.h>
> > >
> > >  #include "audit.h"
> > >
> > > @@ -2877,10 +2878,28 @@ void __audit_log_kern_module(char *name)
> > >         context->type = AUDIT_KERN_MODULE;
> > >  }
> > >
> > > -void __audit_fanotify(u32 response)
> > > +void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> > >  {
> > > -       audit_log(audit_context(), GFP_KERNEL,
> > > -               AUDIT_FANOTIFY, "resp=%u", response);
> > > +       struct audit_context *ctx = audit_context();
> > > +       struct audit_buffer *ab;
> > > +       char numbuf[12];
> > > +
> > > +       if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> > > +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > > +                         "resp=%u fan_type=%u fan_info=3F subj_trust=2 obj_trust=2",
> > > +                         response, FAN_RESPONSE_INFO_NONE);
> >
> > The fan_info, subj_trust, and obj_trust constant values used here are
> > awfully magic-numbery and not the usual sentinel values one might
> > expect for a "none" operation, e.g. zeros/INT_MAX/etc. I believe a
> > comment here explaining the values would be a good idea.
>
> Ack.  I'll add a comment.  I would have preferred zero for default of
> unset, but Steve requested 0/1/2 no/yes/unknown.

Yeah, if they were zeros I don't think we would need to comment on
them as zeros for unset/unknown/invalid is rather common, 2 ... not so
much.

-- 
paul-moore.com
