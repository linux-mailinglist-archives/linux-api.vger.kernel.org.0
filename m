Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5387C198287
	for <lists+linux-api@lfdr.de>; Mon, 30 Mar 2020 19:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgC3Rkg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Mar 2020 13:40:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36085 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgC3Rkg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Mar 2020 13:40:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id c23so615213pgj.3
        for <linux-api@vger.kernel.org>; Mon, 30 Mar 2020 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EIazmoWr1nLxxc8KNs37fnm42F/lDdp4/gYm3JHLHek=;
        b=IoKCdJlIr8dKSUui+FFl2O8BLgUnbJF6UcpsVTBUCUIxnVlSObs8uqbpJtVfo85MHD
         NSMiSHyRzun2Qw2uFSqKhacVvS9T1di6LetUQD1cCrF9rPt/SGxOjvQEku1cIwKpUsK4
         Nyhahu2qk/o5MwyQBOY1XNgL+3twDOfx4D+Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EIazmoWr1nLxxc8KNs37fnm42F/lDdp4/gYm3JHLHek=;
        b=CfBbjcdNX3V5UEL5DZbDrZgjxuv9qeEWfAYPmjhacSRcJkbSm1uDhjLNEMlMslsjuj
         pAlQTlSW7D5UHGymaTzLRTshKRscnJbJe1o4gC4ysixayaKDLFO9G/WNG77waWSCFM8k
         DPiPyXUFJ02hW0swWlwTxXmiH5eab6F24pOav4wdYSkt0MLs3ywT/d4kb5t8QGK01LTL
         zd6rNnkUdJe2oWysH2vMMPqEy9pzZOwA1UFje+/bA2MoRV7M7PFoBEfTC3BfX1zQkXMW
         Pfc6AtVkNIAKEl2z6FjilylaDMGRyGaBDzdwzdPtlkdijjoLXkuVQ+dmteZ9BQETA4R5
         mBWQ==
X-Gm-Message-State: ANhLgQ0iL5ldwBLv6VXnRzFkj6gBeCb+TIIsuRDVKKbqYPCzesay9FMn
        LnVecTvcbB1aGdJ8cL5cbUk49g==
X-Google-Smtp-Source: ADFU+vsp6F+mnbmu4oeH1BZE4z851b8UTWueJ6LJmiWqqkcFzAPvDpoG8s71ddjkdVNmXYn/ukbhqw==
X-Received: by 2002:a63:cf:: with SMTP id 198mr14239682pga.447.1585590035454;
        Mon, 30 Mar 2020 10:40:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i2sm10410628pfr.203.2020.03.30.10.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:40:34 -0700 (PDT)
Date:   Mon, 30 Mar 2020 10:40:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202003301040.E3099A957@keescook>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <c68b1ed4-51ef-ca65-7128-ff3c8b6b54ee@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c68b1ed4-51ef-ca65-7128-ff3c8b6b54ee@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 30, 2020 at 06:23:57PM +0200, Vlastimil Babka wrote:
> Boo, all the error prints should terminate with \n
> Will wait for feedback before resend.

eek, yes, good catch. :)

-- 
Kees Cook
