Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA852C8E29
	for <lists+linux-api@lfdr.de>; Mon, 30 Nov 2020 20:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgK3Tfz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Nov 2020 14:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgK3Tfy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Nov 2020 14:35:54 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBD0C0613D6
        for <linux-api@vger.kernel.org>; Mon, 30 Nov 2020 11:35:14 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id w4so10679323pgg.13
        for <linux-api@vger.kernel.org>; Mon, 30 Nov 2020 11:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zoIMtVE4+1+o9p0pbm0cQZHtnOHf9cojfw2g8Pzl99w=;
        b=nFwXZN+9x1uRKlRpb2fisB/ELkMzUI7nBOTDK+3QkUAWIm3IfPiJqiGjivf6F3sSwv
         RoZyHi7CgxvW3SSOZQ2cU1/KY0Iy+CUvtAsqwt6VbmFNVW6B+eL6V31xyW900NDwZht5
         N2oHTj6Gh8XEDl0zpxkojlT54hjr847iaIKNqFW9i3ucnsLmDSouyItCamuTeqB2jgEm
         0AXOJ61q3ZHbh7mqIh6vCm6/n53SmiKHvl5J6WQtgx6lhqPLoAlk4NAHMXWCsP8Sta+x
         RZJhxhos8lefJMBl3CLwk3ul9mLSpsmV5sZfheVZtdZuZ8VK8F4zN5m0ix/m3QpJBjKp
         OnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zoIMtVE4+1+o9p0pbm0cQZHtnOHf9cojfw2g8Pzl99w=;
        b=jtRS8jOWYKoQKmbR8ChCczLeB43shCPacVH7KBwR8s7Z4hfPsQFyX2VBNmZg9KA1Wt
         bHu0c2WnqhKpHVPPCIaSc0P9j8uFUoIxHs7W0vC3TOeuYy8U4Lk6epRUd1dEqrA8JDcI
         PPuVJGaTP2v7DiDJQu1CxA4AfNy+q5K41WvMnrnBrsNeDki5CXv1k9y0ha6Fpxzf7dWn
         Qyct9FdaSXYdWg6DFjiPMHNU/9SL+yR/UcV1cJy8blZsBPzgzD7vRBUTy6+3jtl6218k
         mndOcQ8Awkodwc5mkagm2e0co/t9fOFuZtzY4pL8TN6nmOwIEcDBYM9n3BKlTUFVa2Xu
         drig==
X-Gm-Message-State: AOAM531ybrD1DjpQ3kxUzscuprTMYkp/pOuwH7JR9K4dfM8JpkuFAXb0
        KUbjoxjumbk6EhzZA2EL+SEuow==
X-Google-Smtp-Source: ABdhPJyg/H6c/EHEcuAnEkbxBKhJCsZbEssRrqxYEujREgZsvL9Edhwh0+EkZiCX44t3hNqjg9XPLg==
X-Received: by 2002:a63:f857:: with SMTP id v23mr19059138pgj.174.1606764913878;
        Mon, 30 Nov 2020 11:35:13 -0800 (PST)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::b2be])
        by smtp.gmail.com with ESMTPSA id s10sm10916857pgg.76.2020.11.30.11.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 11:35:12 -0800 (PST)
Date:   Mon, 30 Nov 2020 11:35:10 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH man-pages v6] Document encoded I/O
Message-ID: <X8VJbqz+XtA5Vmth@relinquished.localdomain>
References: <cover.1605723568.git.osandov@fb.com>
 <ec1588a618bd313e5a7c05a7f4954cc2b76ddac3.1605724767.git.osandov@osandov.com>
 <4d1430aa-a374-7565-4009-7ec5139bf311@gmail.com>
 <fb4a4270-eb7a-06d5-e703-9ee470b61f8b@gmail.com>
 <05e1f13c-5776-961b-edc4-0d09d02b7829@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e1f13c-5776-961b-edc4-0d09d02b7829@gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 20, 2020 at 04:03:44PM +0100, Alejandro Colomar (man-pages) wrote:
> Hi Omar,
> 
> I found a wording of mine to be a bit confusing.
> Please see below.
> 
> Thanks,
> 
> Alex
> 
> On 11/20/20 3:06 PM, Alejandro Colomar (man-pages) wrote:
> > Hi Omar and Michael,
> > 
> > please, see below.
> > 
> > Thanks,
> > 
> > Alex
> > 
> > On 11/20/20 12:29 AM, Alejandro Colomar (mailing lists; readonly) wrote:
> >> Hi Omar,
> >>
> >> Please, see some fixes below:
> >>
> >> Michael, I've also some questions for you below
> >> (you can grep for mtk to find those).
> >>
> >> Thanks,
> >>
> >> Alex

Thanks for the suggestions, I'll incorporate those into the next
submission.
