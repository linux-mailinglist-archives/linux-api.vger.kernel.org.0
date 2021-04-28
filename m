Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B711E36E1E6
	for <lists+linux-api@lfdr.de>; Thu, 29 Apr 2021 01:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhD1Wyc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Apr 2021 18:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbhD1Wy3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Apr 2021 18:54:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCF1C06138B
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 15:53:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b14-20020a17090a6e0eb0290155c7f6a356so2799264pjk.0
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iZ7QHc2ykOTQ3tVESh83HRmneBd7oEDH+LeHNMcXAHY=;
        b=cMV5Vtn9qduFGokuJESHEgCSHOAYUgReeSgxCag9K7Nc4Kq2A5h4tyP+iKqa03Jmdj
         WDkpHheGiMG1xt/XzEnpetDqoojsx/EIxeOw3p469HRqrB85mRqQf9fHIcgBDsAMipiJ
         CzYooSJUHIbS6hsRNpOWa1e6xsLZjsfVe6KXtR2PxJst6qFBImZRO6OPO/JYZu8wkO2y
         93cbWbmIhqsFtorUdyDdg3319fk2qzpQ9kte3rLc79jE67HgSTygjcUe6npbPP1pmyhT
         ri0wYPI5ew2Dkk6s2UFFqzhlQH2w96d2XCvt5WNIo/AHMdIzkmBIYP+mmmQQc++KnVHX
         6+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iZ7QHc2ykOTQ3tVESh83HRmneBd7oEDH+LeHNMcXAHY=;
        b=an8q4JWoTG4l8U+lNMr8v/jAqKhUqmUEaMi7am+L7+NX6zPgCxc2APaUE04z6G2o/d
         6EXS5tyIC587/vIGqKYviPW4NPfYsjN6ktxU1/qhhJoMTNV1SS9caX5lG1Zo/TJ8cRYP
         Zq7xuhU1B5qsIo9eJzt1Vyok+4o4fwpJilPEy+PeHpEZZVgpkS8o0ZjBTRUw1NM13Rst
         c5XuMG3HqBF1KHlWKLiLNBmjx6yXroAlDaoK7ffcht9NlXpofcbhaxjhJ+wblGiFscoU
         Q+PM4+C0whTl1iCQJ+lXjmN76+cq+v40wuD3gi3j4sycweon0J2W6J+EfSq9G5D4m3vk
         AoKw==
X-Gm-Message-State: AOAM5321JKAZO5ONmWUDQR8emcWf2LcIAGlBUZl6btyjiUWOornMj/2d
        qRwEJFBlGeFw65g1aYrJG/Z4Onb+MAmuFoT1
X-Google-Smtp-Source: ABdhPJxSw7sv6m8hQEf/6OcaSoGjSg7zqhzeIXlFaRLMxIzIbWUCMoXviVnCAdUcibOTru8NxAWmKA==
X-Received: by 2002:a17:90a:f3d1:: with SMTP id ha17mr6500911pjb.123.1619650423529;
        Wed, 28 Apr 2021 15:53:43 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3ae5:2a7f:7b15:7b41])
        by smtp.gmail.com with ESMTPSA id 31sm654376pgw.3.2021.04.28.15.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:53:42 -0700 (PDT)
Date:   Thu, 29 Apr 2021 08:53:31 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <YInna8fT/WfUkV6+@google.com>
References: <YH4+Swki++PHIwpY@google.com>
 <20210421080449.GK8706@quack2.suse.cz>
 <YIIBheuHHCJeY6wJ@google.com>
 <CAOQ4uxhUcefbu+5pLKfx7b-kOPP2OB+_RRPMPDX1vLk36xkZnQ@mail.gmail.com>
 <YIJ/JHdaPv2oD+Jd@google.com>
 <CAOQ4uxhyGKSM3LFKRtgNe+HmkUJRCFwafXdgC_8ysg7Bs43rWg@mail.gmail.com>
 <YIaVbWu8up3RY7gf@google.com>
 <CAOQ4uxhp3khQ9Ln2g9s5WLEsb-Cv2vdsZTuYUgQx-DW6GR1RmQ@mail.gmail.com>
 <YIeGefkB+cHMsDse@google.com>
 <CAOQ4uxjAqh3xVpigrJe1k01Fy5-rJRxxLGw92BwWtU4zjr=Wjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjAqh3xVpigrJe1k01Fy5-rJRxxLGw92BwWtU4zjr=Wjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 27, 2021 at 08:14:05AM +0300, Amir Goldstein wrote:
> On Tue, Apr 27, 2021 at 6:35 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > On Mon, Apr 26, 2021 at 02:11:30PM +0300, Amir Goldstein wrote:
> > > > Amir, I was just thinking about this a little over the weekend and I
> > > > don't think we discussed how to handle the FAN_REPORT_PIDFD |
> > > > FAN_REPORT_FID and friends case? My immediate thought is to make
> > > > FAN_REPORT_PIDFD mutually exclusive with FAN_REPORT_FID and friends,
> > > > but then again receiving a pidfd along with FID events may be also
> > > > useful for some? What are your thoughts on this? If we don't go ahead
> > > > with mutual exclusion, then this multiple event types alongside struct
> > > > fanotify_event_metadata starts getting a little clunky, don't you
> > > > think?
> > > >
> > >
> > > The current format of an fanotify event already supports multiple info records:
> > >
> > > [fanotify_event_metadata]
> > > [[fanotify_event_info_header][event record #1]]
> > > [[fanotify_event_info_header][event record #2]]...
> > >
> > > (meta)->event_len is the total event length including all info records.
> > >
> > > For example, FAN_REPORT_FID | FAN_REPORT_DFID_MAME produces
> > > (for some events) two info records, one FAN_EVENT_INFO_TYPE_FID
> > > record and one FAN_EVENT_INFO_TYPE_DFID_NAME record.
> >
> > Ah, that's right! I now remember reviewing some patches associated
> > with the FID change series which mentioned the possibility of
> > receiving multiple FID info records. As the implementation currently
> > stands, AFAIK there's not possibility for fanotify to ever return more
> > than two info records, right?
> >
> > Is there any preference in terms of whether the new FAN_REPORT_PIDFD
> > info records precede or come after FAN_REPORT_FID/FAN_REPORT_DFID_NAME
> > info records in FAN_REPORT_FID or FAN_REPORT_FID |
> > FAN_REPORT_DFID_NAME configurations?
>
> Doesn't matter.

OK, fair.

> Your typical application would first filter by pid/pidfd and only if process
> matches the filters would it care to examine the event fid info, correct?

Not necessarily, but you're right, the ordering doesn't really matter
too much.

/M
