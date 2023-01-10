Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1206637AE
	for <lists+linux-api@lfdr.de>; Tue, 10 Jan 2023 04:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbjAJDJI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Jan 2023 22:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbjAJDJB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Jan 2023 22:09:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A471147A
        for <linux-api@vger.kernel.org>; Mon,  9 Jan 2023 19:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673320091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUXSaju3UPzIvAC6Of9JSQqq9SpOu4cYG4J3V6EbO2k=;
        b=W6UAK8v0CJ8ORjHAaq8Du16Me7TCAijxCwF+LOF8s9Ufe0ASv3XBASt71mCGQViMGhisMM
        Dx+Ny4uUtxqp9Gu6zcJ++zjDcSEsUy0ZPoEP8JRz+vW9KXzx2S1Ud/0p07qSjsuNnDd8aZ
        FR1UV5swMP3dMzCISyGhBeg0eM2C4UI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-fMQdw4GlOKeewiKddYad9w-1; Mon, 09 Jan 2023 22:08:08 -0500
X-MC-Unique: fMQdw4GlOKeewiKddYad9w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E22F810C29;
        Tue, 10 Jan 2023 03:08:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6DCB492B00;
        Tue, 10 Jan 2023 03:08:06 +0000 (UTC)
Date:   Mon, 9 Jan 2023 22:08:04 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v5 3/3] fanotify,audit: Allow audit to use the full
 permission event response
Message-ID: <Y7zWlFbrrNcfGauJ@madcap2.tricolour.ca>
References: <cover.1670606054.git.rgb@redhat.com>
 <79fcf72ea442eeede53ed5e6de567f8df8ef7d83.1670606054.git.rgb@redhat.com>
 <3211441.aeNJFYEL58@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3211441.aeNJFYEL58@x2>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2023-01-09 19:06, Steve Grubb wrote:
> Hello,
> 
> Sorry to take so long. Holidays and kernel build problems. However, I have 
> built a kernel with these patches. I only have 2 comments. When I use an 
> application that expected the old API, meaning it simply does:
> 
>         response.fd = metadata->fd;
>         response.response = reply;
>         close(metadata->fd);
>         write(fd, &response, sizeof(struct fanotify_response));
> 
> I get access denials. Every time. If the program is using the new API and 
> sets FAN_INFO, then it works as expected. I'll do some more testing but I 
> think there is something wrong in the compatibility path.

I'll have a closer look, because this wasn't the intended behaviour.

> On Monday, December 12, 2022 9:06:11 AM EST Richard Guy Briggs wrote:
> > This patch passes the full response so that the audit function can use all
> > of it. The audit function was updated to log the additional information in
> > the AUDIT_FANOTIFY record.
> 
> What I'm seeing is:
> 
> type=FANOTIFY msg=audit(01/09/2023 18:43:16.306:366) : resp=deny fan_type=1 
> fan_info=313300000000000000000000 subj_trust=0 obj_trust=0
> 
> Where fan_info was supposed to be 13 decimal. More below...

Well, it *is* 13 decimal, expressed as a hex-encoded string as was
requested for future-proofing, albeit longer than necessary...

> > Currently the only type of fanotify info that is defined is an audit
> > rule number, but convert it to hex encoding to future-proof the field.
> > Hex encoding suggested by Paul Moore <paul@paul-moore.com>.
> > 
> > Sample records:
> >   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1
> > fan_info=3137 subj_trust=3 obj_trust=5 type=FANOTIFY
> > msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F subj_trust=2
> > obj_trust=2
> > 
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/notify/fanotify/fanotify.c |  3 ++-
> >  include/linux/audit.h         |  9 +++++----
> >  kernel/auditsc.c              | 25 ++++++++++++++++++++++---
> >  3 files changed, 29 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 24ec1d66d5a8..29bdd99b29fa 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -273,7 +273,8 @@ static int fanotify_get_response(struct fsnotify_group
> > *group,
> > 
> >  	/* Check if the response should be audited */
> >  	if (event->response & FAN_AUDIT)
> > -		audit_fanotify(event->response & ~FAN_AUDIT);
> > +		audit_fanotify(event->response & ~FAN_AUDIT,
> > +			       &event->audit_rule);
> > 
> >  	pr_debug("%s: group=%p event=%p about to return ret=%d\n", __func__,
> >  		 group, event, ret);
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index d6b7d0c7ce43..31086a72e32a 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/audit_arch.h>
> >  #include <uapi/linux/audit.h>
> >  #include <uapi/linux/netfilter/nf_tables.h>
> > +#include <uapi/linux/fanotify.h>
> > 
> >  #define AUDIT_INO_UNSET ((unsigned long)-1)
> >  #define AUDIT_DEV_UNSET ((dev_t)-1)
> > @@ -416,7 +417,7 @@ extern void __audit_log_capset(const struct cred *new,
> > const struct cred *old); extern void __audit_mmap_fd(int fd, int flags);
> >  extern void __audit_openat2_how(struct open_how *how);
> >  extern void __audit_log_kern_module(char *name);
> > -extern void __audit_fanotify(u32 response);
> > +extern void __audit_fanotify(u32 response, struct
> > fanotify_response_info_audit_rule *friar); extern void
> > __audit_tk_injoffset(struct timespec64 offset);
> >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> >  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int
> > nentries, @@ -523,10 +524,10 @@ static inline void
> > audit_log_kern_module(char *name) __audit_log_kern_module(name);
> >  }
> > 
> > -static inline void audit_fanotify(u32 response)
> > +static inline void audit_fanotify(u32 response, struct
> > fanotify_response_info_audit_rule *friar) {
> >  	if (!audit_dummy_context())
> > -		__audit_fanotify(response);
> > +		__audit_fanotify(response, friar);
> >  }
> > 
> >  static inline void audit_tk_injoffset(struct timespec64 offset)
> > @@ -679,7 +680,7 @@ static inline void audit_log_kern_module(char *name)
> >  {
> >  }
> > 
> > -static inline void audit_fanotify(u32 response)
> > +static inline void audit_fanotify(u32 response, struct
> > fanotify_response_info_audit_rule *friar) { }
> > 
> >  static inline void audit_tk_injoffset(struct timespec64 offset)
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index d1fb821de104..8d523066d81f 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -64,6 +64,7 @@
> >  #include <uapi/linux/limits.h>
> >  #include <uapi/linux/netfilter/nf_tables.h>
> >  #include <uapi/linux/openat2.h> // struct open_how
> > +#include <uapi/linux/fanotify.h>
> > 
> >  #include "audit.h"
> > 
> > @@ -2877,10 +2878,28 @@ void __audit_log_kern_module(char *name)
> >  	context->type = AUDIT_KERN_MODULE;
> >  }
> > 
> > -void __audit_fanotify(u32 response)
> > +void __audit_fanotify(u32 response, struct
> > fanotify_response_info_audit_rule *friar) {
> > -	audit_log(audit_context(), GFP_KERNEL,
> > -		AUDIT_FANOTIFY,	"resp=%u", response);
> > +	struct audit_context *ctx = audit_context();
> > +	struct audit_buffer *ab;
> > +	char numbuf[12];
> > +
> > +	if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> > +		audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > +			  "resp=%u fan_type=%u fan_info=3F subj_trust=2 
> obj_trust=2",
> > +			  response, FAN_RESPONSE_INFO_NONE);
> > +		return;
> > +	}
> > +	ab = audit_log_start(ctx, GFP_KERNEL, AUDIT_FANOTIFY);
> > +	if (ab) {
> > +		audit_log_format(ab, "resp=%u fan_type=%u fan_info=",
> > +				 response, friar->hdr.type);
> > +		snprintf(numbuf, sizeof(numbuf), "%u", friar->rule_number);
> > +		audit_log_n_hex(ab, numbuf, sizeof(numbuf));
> 
> I don't think it needs to be converted to ascii and then hexencoded. As Paul 
> said, probably %X is all we need here.
> 
> -Steve
> 
> 
> > +		audit_log_format(ab, " subj_trust=%u obj_trust=%u",
> > +				 friar->subj_trust, friar->obj_trust);
> > +		audit_log_end(ab);
> > +	}
> >  }
> > 
> >  void __audit_tk_injoffset(struct timespec64 offset)
> 
> 
> 
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

