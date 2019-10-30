Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095ADEA4B4
	for <lists+linux-api@lfdr.de>; Wed, 30 Oct 2019 21:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfJ3U1t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Oct 2019 16:27:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36866 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfJ3U1t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Oct 2019 16:27:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id v2so4161143lji.4
        for <linux-api@vger.kernel.org>; Wed, 30 Oct 2019 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThGwTwTp4bZorwdaVrJo5UrBBQpibM4/aFgMPeqwm5E=;
        b=Gm26HZjBU2uuF0YwNHad3PnEOS9hPuQTAg5xL7kLdu1O0WluIGq1cH3+PRhpQA13vV
         DzJcMXPCM9W8+4OJdqpUeo+8QRGh5ku4KjkX3UXlZwiY0DplbVDpIeYteu6gUojdVbs5
         mUtDG6M08OxHZHB8ByhYFJU5gRby7guMdJOT5/rDe1UgpD+wozzw+ldkHqw2hOGWgSgX
         z2TG+GeNvNZTeklnHV4TABaWX73PY1s8dd/WdZEldbqY0CI8zPzqKKtvWrYIMtCXgbL9
         9QaZ/ySBZRyXq/rzWIbzVIdEiwfPLCVIKoMAl2zXvtZapKIHcEUdOj3jmaGDvAyziTnw
         jT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThGwTwTp4bZorwdaVrJo5UrBBQpibM4/aFgMPeqwm5E=;
        b=BUh5JIPKPLB414NhW6XM/1D6zgjkwC8SFA5M8sGdfkudaufGWtJA/nylUBHLplzNl0
         Kp/MGzygWnved9EpYZW6ZVE32CN28GvgqDyZVFA1Gc0EJSNyOwv6nFkiPa+Erqaok2cn
         qMAeZaIithvpqR1S8+aZDThG9FXzZbBCcw/KM9nCSTGg+ImCAj75U5W96A2EbMrIQCno
         zdfoDl5Swl2Pe1uKGqbfAyJnu1xWs/I8GWFdstSAq6knDHKebOUa2cRfu7bG1BrIJLWc
         XOfvBYtgTJ4SL+JDnH5972ZXfip/ohUbtR6skUi71wjUHTSQg+DOFwGQKnEQxdrIEyl4
         9eHg==
X-Gm-Message-State: APjAAAWGQRnJkuaE3G58BTV3sLoe8D/zm0hca9JsZp7+BI1v3bbm5ONw
        EZDtymUWofBmce+hw/5sCTf4CwyDUtbpYnUPydJ0
X-Google-Smtp-Source: APXvYqwNJV+fESPPSy88I8V9SQJjpifZuNL/1FipNLKwD0hUFyI8ehvSjLCN+oZyru7R02+LN8E0BXtmTH/ZA5bgmuo=
X-Received: by 2002:a2e:58d:: with SMTP id 135mr1059911ljf.57.1572467266987;
 Wed, 30 Oct 2019 13:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <214163d11a75126f610bcedfad67a4d89575dc77.1568834525.git.rgb@redhat.com>
 <20191019013904.uevmrzbmztsbhpnh@madcap2.tricolour.ca> <CAHC9VhRPygA=LsHLUqv+K=ouAiPFJ6fb2_As=OT-_zB7kGc_aQ@mail.gmail.com>
 <20191021213824.6zti5ndxu7sqs772@madcap2.tricolour.ca> <CAHC9VhRdNXsY4neJpSoNyJoAVEoiEc2oW5kSscF99tjmoQAxFA@mail.gmail.com>
 <20191021235734.mgcjotdqoe73e4ha@madcap2.tricolour.ca> <CAHC9VhSiwnY-+2awxvGeO4a0NgfVkOPd8fzzBVujp=HtjskTuQ@mail.gmail.com>
 <20191024210010.owwgc3bqbvtdsqws@madcap2.tricolour.ca>
In-Reply-To: <20191024210010.owwgc3bqbvtdsqws@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Oct 2019 16:27:35 -0400
Message-ID: <CAHC9VhRDoX9du4XbCnBtBzsNPMGOsb-TKM1CC+sCL7HP=FuTRQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 20/21] audit: add capcontid to set contid
 outside init_user_ns
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 24, 2019 at 5:00 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Here's the note I had from that meeting:
>
> - Eric raised the issue that using /proc is likely to get more and more
>   hoary due to mount namespaces and suggested that we use a netlink
> audit message (or a new syscall) to set the audit container identifier
> and since the loginuid is a similar type of operation, that it should be
> migrated over to a similar mechanism to get it away from /proc.  Get
> could be done with a netlink audit message that triggers an audit log
> message to deliver the information.  I'm reluctant to further pollute
> the syscall space if we can find another method.  The netlink audit
> message makes sense since any audit-enabled service is likely to already
> have an audit socket open.

Thanks for the background info on the off-list meeting.  I would
encourage you to have discussions like this on-list in the future; if
that isn't possible, hosting a public call would okay-ish, but a
distant second.

At this point in time I'm not overly concerned about /proc completely
going away in namespaces/containers that are full featured enough to
host a container orchestrator.  If/when reliance on procfs becomes an
issue, we can look at alternate APIs, but given the importance of
/proc to userspace (including to audit) I suspect we are going to see
it persist for some time.  I would prefer to see you to drop the audit
container ID netlink API portions of this patchset and focus on the
procfs API.

Also, for the record, removing the audit loginuid from procfs is not
something to take lightly, if at all; like it or not, it's part of the
kernel API.

-- 
paul moore
www.paul-moore.com
