Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE474445F0
	for <lists+linux-api@lfdr.de>; Thu, 13 Jun 2019 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfFMQsC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Jun 2019 12:48:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44508 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbfFMEvv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Jun 2019 00:51:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so10170813pgp.11;
        Wed, 12 Jun 2019 21:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LhqXtJGGhegyYExHZ1WF6p3NXokQdCloSJ49B5IQyX0=;
        b=sML9I7+Oymh+dq+TJhqSRnPXQAzZvIyyKJ7YFGVFU7zMdaMChzc0VXnA5OfDP8Qpys
         r1WVoOA6lakTBoH3eca/NE7fY9Oqs8JUafDzlGF2PDCzBIGbU0wF7y164P9gJ7Clo36S
         FMWlUk3RZRw6C18Fl2k1ikE7kH9xR8ytvYnLeRLxgw/flRUvwiCJtnU57V/+PbnPX/K/
         caSAfCjEJiSyYdmnO9Z8j+AXazpOCWoz89JzEtwOhRBniNClcb9O+qrnAdqzgPJxuYQN
         ztk1f+S1dtud0Idwd9te+HHaoRkE2EI9o1MTIOqlhbmJ0tpmJ+BVXfeNVYFO5iZDpsd/
         WiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LhqXtJGGhegyYExHZ1WF6p3NXokQdCloSJ49B5IQyX0=;
        b=Qx80pTUqbAZyFNKavXk9WjwMBHa+5Je0739j3zay2KkuoycR2RvbRlzGYCDYxreRNJ
         0t2WBRcv0kIFt2pmrZ/BGOYb412pLcg4zcbMGLmxRX9CVqr7xauUNzIMeVP6UapcVvsw
         7TKlIcsa/M74iWGoHFL9fEPp/SHdZFtXba9WCv11+jeMFc0B7vzPKC8QF9eTaepAREdW
         AwVTMWp5CQ6txNWZdoKgla+CYQX56eez1lwzOKdSoo4ujIl0sDrykI0zvQi1TKRUMdSs
         nXyu/MxH9JcxbxHDcKybUPBiq/eVj/CbYzfYeWOPWve17sqryMskJ90af0IQKhRInNXm
         zF8w==
X-Gm-Message-State: APjAAAV3PzLSFBVQhjqwmNhISCTw8VdlcefgCiGDpgHiwbW4EP3hvzv8
        PMSm53L/OQUKBESmPVgkTLA=
X-Google-Smtp-Source: APXvYqx3MxqqjBUhjTx2s1nicOEmErxR4OMfZE/gEbezinCYmvQK0bHgQez9jY7V95zRptnafvZHiA==
X-Received: by 2002:a17:90a:5d0a:: with SMTP id s10mr3018998pji.94.1560401510974;
        Wed, 12 Jun 2019 21:51:50 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id u23sm1266432pfn.140.2019.06.12.21.51.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 21:51:49 -0700 (PDT)
Date:   Thu, 13 Jun 2019 13:51:42 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com
Subject: Re: [PATCH v2 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Message-ID: <20190613045142.GG55602@google.com>
References: <20190610111252.239156-1-minchan@kernel.org>
 <21cf2918-ba0e-aae1-a20e-36ee1ad4f704@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21cf2918-ba0e-aae1-a20e-36ee1ad4f704@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 10, 2019 at 11:03:00AM -0700, Dave Hansen wrote:
> I'd really love to see the manpages for these new flags.  The devil is
> in the details of our promises to userspace.

I'm waiting comments from reviewers since I have fixed what they point
out from the previous version.

I will add manpage material in respin after the getting more feedback.
Thanks.
