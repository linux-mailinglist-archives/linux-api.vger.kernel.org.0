Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5345D675D1C
	for <lists+linux-api@lfdr.de>; Fri, 20 Jan 2023 19:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjATSwy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Jan 2023 13:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjATSww (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Jan 2023 13:52:52 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99DE4B1B3
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 10:52:49 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r18so4807993pgr.12
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 10:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FPfy+reM6AKfPj+P9Rafnu4Ibypa0LESref2+wODD18=;
        b=Qfzg23MVKgyve2XBzoW31NlYobIFWVOHHhwhcxalDk919SMGtf0YJaHtxZMf1d6Ji3
         4kmpjikIrJlw3ahROk+iqBz3xm4E5b8+wOCe8Y2OD9DuMHBpV0bPHaDe6nWFE4ZUt+RE
         IbjV9G8LXvyOHLU3mO5csO9PXC5pYbXfGAgBgGh1ZijJsBfuNsS0xomY2QZuLqi4xJFI
         69aQdSdznYDRBBSGBz64fiG/Tth12IfyMbr0gpjdtopykXPMh5FejbsR1l9SumXbwwVj
         i4yXq2VEpOfK7TunocUMGhyjljpG5oQLInecNKf09hsbPsmErfOtYsue28Ccdw8rX3Hj
         ubsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPfy+reM6AKfPj+P9Rafnu4Ibypa0LESref2+wODD18=;
        b=cLT53P+10q1NHSJRBURC+IjbkJ6De60CTZ8oQKhFhh4BSS28jugIKxLTfrT5+H/ga9
         /LYaUv9A9/aAIyDvxbS1mFWVWrDTTzeYGF3bHZE0GjPTw+69IDviQCYvNVFb2ERKXBOK
         zGzocf2ZZ4x+lX6hJTnldYPCLeUVxCgtl18HOJUT1ftZfjqCWs+v3ymCPm8mAWcI1mXQ
         y6EILa8xQM29C92lFtA7jvvpmic/dwJRlIU7PrqF16ZvQDVRwLRtiLn4ftJFR3t/hasF
         f0HHU6p7FrpfHOgpYRmdl+Gixobzi75kZrIXxeyNzXaxNKKcCUMeoRu0XnhDKhCMy9gh
         hOPg==
X-Gm-Message-State: AFqh2krptaPCeRh+GgzFdVzaDVQqOs2tqtBEopssAXF/lB78qfYZ+5ZF
        TxtYs21J+ucMsaZdqp7+LfrbJr9Hnjuwdipxu/6p
X-Google-Smtp-Source: AMrXdXv6XdC27v9Qt7fHt//RR9OOqJAxF6QqxrildvdTUbBXmQAvsFo9EGfhk/9ydU1jbeskiocoXCzAHBK0epOqvSo=
X-Received: by 2002:a05:6a00:f07:b0:577:62a8:f7a1 with SMTP id
 cr7-20020a056a000f0700b0057762a8f7a1mr1561601pfb.2.1674240769040; Fri, 20 Jan
 2023 10:52:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673989212.git.rgb@redhat.com> <82aba376bfbb9927ab7146e8e2dee8d844a31dc2.1673989212.git.rgb@redhat.com>
 <5680172.DvuYhMxLoT@x2>
In-Reply-To: <5680172.DvuYhMxLoT@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Jan 2023 13:52:37 -0500
Message-ID: <CAHC9VhQbSCxmSbLFJZidAr952uHt-KktfRRJN3Lr+uDSCzHtfQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] fanotify,audit: Allow audit to use the full
 permission event response
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Richard Guy Briggs <rgb@redhat.com>,
        Eric Paris <eparis@parisplace.org>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jan 18, 2023 at 1:34 PM Steve Grubb <sgrubb@redhat.com> wrote:
>
> Hello Richard,
>
> I built a new kernel and tested this with old and new user space. It is
> working as advertised. The only thing I'm wondering about is why we have 3F
> as the default value when no additional info was sent? Would it be better to
> just make it 0?

...

> On Tuesday, January 17, 2023 4:14:07 PM EST Richard Guy Briggs wrote:
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index d1fb821de104..3133c4175c15 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2877,10 +2878,19 @@ void __audit_log_kern_module(char *name)
> >       context->type = AUDIT_KERN_MODULE;
> >  }
> >
> > -void __audit_fanotify(u32 response)
> > +void __audit_fanotify(u32 response, struct
> > fanotify_response_info_audit_rule *friar) {
> > -     audit_log(audit_context(), GFP_KERNEL,
> > -             AUDIT_FANOTIFY, "resp=%u", response);
> > +     /* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
> > +     if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> > +             audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > +                       "resp=%u fan_type=%u fan_info=3F subj_trust=2
> obj_trust=2",
> > +                       response, FAN_RESPONSE_INFO_NONE);
> > +             return;
> > +     }

(I'm working under the assumption that the "fan_info=3F" in the record
above is what Steve was referring to in his comment.)

I vaguely recall Richard commenting on this in the past, although
maybe not ... my thought is that the "3F" is simply the hex encoded
"?" character in ASCII ('man 7 ascii' is your friend).  I suppose the
question is what to do in the FAN_RESPONSE_INFO_NONE case.

Historically when we had a missing field we would follow the "field=?"
pattern, but I don't recall doing that for a field which was
potentially hex encoded, is there an existing case where we use "?"
for a field that is hex encoded?  If so, we can swap out the "3F" for
a more obvious "?".

However, another option might be to simply output the current
AUDIT_FANOTIFY record format in the FAN_RESPONSE_INFO_NONE case, e.g.
only "resp=%u".  This is a little against the usual guidance of
"fields should not disappear from a record", but considering that
userspace will always need to support the original resp-only format
for compatibility reasons this may be an option.

--
paul-moore.com
