Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF9C36BDC7
	for <lists+linux-api@lfdr.de>; Tue, 27 Apr 2021 05:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhD0DgW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Apr 2021 23:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhD0DgS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Apr 2021 23:36:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ABBC061756
        for <linux-api@vger.kernel.org>; Mon, 26 Apr 2021 20:35:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q10so41404326pgj.2
        for <linux-api@vger.kernel.org>; Mon, 26 Apr 2021 20:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+23tsuGkZtrEXwPI12jDygL4YAiJ2E0ujUqFvafR0bs=;
        b=jhW07Q4f0zAoXn0N3Bz/6Ca4VwEuUXIN/WHZhGVis2UqSnIzUKyyK4nb+DXKDHlmMI
         NNK3ZEDc7jPVUs1/Vdi9M/9lIcVF1QfYgFUH2NbQsw789R4Xgw0z4vv5HJk7mV9Yqi4f
         AR+M/l0JrNIEUnJ1G9DwxoTNQPB4qEq0k0xclJYr+DQ2zmn8Spm893OaPH+jBtyig7UA
         ND20QOieKNBSYPoCpuIdEYD+hwfpAbgsR5P+F4vRbD/HuEaVivpGYZ0TIceTZJgqBe78
         rgiieupKshrvCrarIdJipjgBW5BidW6FsTaTvagGSMZarTASf2v68Ug2SYVHX3+EOh4k
         JzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+23tsuGkZtrEXwPI12jDygL4YAiJ2E0ujUqFvafR0bs=;
        b=ZJ/I1+/S+aTxslgGFk12F4RB87tR/s34N0bd0Xku18hjc1PWrYmXEPIslV90AfQa6F
         6sCHVld7H/a4fY1PzGhpabsXKt87Jwpb41OieEemeOPbXfE5lqNk/nupU+0BTlvoprkO
         z/hjjbDXTuAiAgm6SZ4dYxQviwzWLWF88O0TR9BjF4hYL9b5PF45KxF+iUYMGQZ61UwA
         c6O6vqvfiG/Hr343fLJFBx5HcOq8qUpSduCFmWGByi63jQNx2Ndkf3U8po098fOgLsXk
         SHCIw25Kq3GYJ8/0nqbChgaiJ0Vz8v7ebhlgy/gDt5RggmAOlNZbwDmfngGOhJeILarv
         kdRw==
X-Gm-Message-State: AOAM533Q9uQUh3VVrQxgQkkVqNZeoSUAl3XMsVEHGfqi2npiAkbZWm57
        TwCbRNzHJQIGymcgRokZCp8Bn/qlUfXmGidVv4U=
X-Google-Smtp-Source: ABdhPJzPciVwVXV41poKecvtwz6f5/TBj3xlxhrgLM1swhMBOMNoWqBaDtYpjFeNEWP46kDgoyxHBg==
X-Received: by 2002:aa7:908d:0:b029:250:81a5:2a3c with SMTP id i13-20020aa7908d0000b029025081a52a3cmr20261154pfa.33.1619494534322;
        Mon, 26 Apr 2021 20:35:34 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:af66:6012:9103:b411])
        by smtp.gmail.com with ESMTPSA id m188sm907284pfm.167.2021.04.26.20.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 20:35:33 -0700 (PDT)
Date:   Tue, 27 Apr 2021 13:35:21 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <YIeGefkB+cHMsDse@google.com>
References: <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein>
 <YH4+Swki++PHIwpY@google.com>
 <20210421080449.GK8706@quack2.suse.cz>
 <YIIBheuHHCJeY6wJ@google.com>
 <CAOQ4uxhUcefbu+5pLKfx7b-kOPP2OB+_RRPMPDX1vLk36xkZnQ@mail.gmail.com>
 <YIJ/JHdaPv2oD+Jd@google.com>
 <CAOQ4uxhyGKSM3LFKRtgNe+HmkUJRCFwafXdgC_8ysg7Bs43rWg@mail.gmail.com>
 <YIaVbWu8up3RY7gf@google.com>
 <CAOQ4uxhp3khQ9Ln2g9s5WLEsb-Cv2vdsZTuYUgQx-DW6GR1RmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhp3khQ9Ln2g9s5WLEsb-Cv2vdsZTuYUgQx-DW6GR1RmQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 26, 2021 at 02:11:30PM +0300, Amir Goldstein wrote:
> > Amir, I was just thinking about this a little over the weekend and I
> > don't think we discussed how to handle the FAN_REPORT_PIDFD |
> > FAN_REPORT_FID and friends case? My immediate thought is to make
> > FAN_REPORT_PIDFD mutually exclusive with FAN_REPORT_FID and friends,
> > but then again receiving a pidfd along with FID events may be also
> > useful for some? What are your thoughts on this? If we don't go ahead
> > with mutual exclusion, then this multiple event types alongside struct
> > fanotify_event_metadata starts getting a little clunky, don't you
> > think?
> >
> 
> The current format of an fanotify event already supports multiple info records:
> 
> [fanotify_event_metadata]
> [[fanotify_event_info_header][event record #1]]
> [[fanotify_event_info_header][event record #2]]...
> 
> (meta)->event_len is the total event length including all info records.
> 
> For example, FAN_REPORT_FID | FAN_REPORT_DFID_MAME produces
> (for some events) two info records, one FAN_EVENT_INFO_TYPE_FID
> record and one FAN_EVENT_INFO_TYPE_DFID_NAME record.

Ah, that's right! I now remember reviewing some patches associated
with the FID change series which mentioned the possibility of
receiving multiple FID info records. As the implementation currently
stands, AFAIK there's not possibility for fanotify to ever return more
than two info records, right?

> So I see no problem with combination of FAN_REPORT_FID
> and FAN_REPORT_PIDFD.

OK.

Is there any preference in terms of whether the new FAN_REPORT_PIDFD
info records precede or come after FAN_REPORT_FID/FAN_REPORT_DFID_NAME
info records in FAN_REPORT_FID or FAN_REPORT_FID |
FAN_REPORT_DFID_NAME configurations?

/M
