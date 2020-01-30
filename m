Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BD614DC45
	for <lists+linux-api@lfdr.de>; Thu, 30 Jan 2020 14:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgA3Nsk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jan 2020 08:48:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40236 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3Nsk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Jan 2020 08:48:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id j104so4104523wrj.7;
        Thu, 30 Jan 2020 05:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=00TW30GXnTchBcJdUYdFPpb46wffdSf5UKCwVXDKN08=;
        b=JYVpkhzyN5O6qKOsWCAAF2p6N3m09kwQN+USLnHNNdqjwVIZql8IY7K1Zly8ZQHXNc
         NTVXxZAvL5NqJ8Ob66dFENEFYay111WTfRr1wLslz6Ey8naHsdeBflvRuRavAEhFfuTM
         94JdjUXSsnSn83uBIkE0zZXTb7XmKowsWRnhGnuFxNLq1/+sIcVPg6fSM2U5tOLX6JHY
         WH6dVZUAmsz5kMYkCRemVJ0qvuKy6gheP9ryDRt7BCiQTF5B+rU66yOTmb9ld42VLM/K
         SrWvUdEu59Vi8nxttm48KvTFjQmB23EmHoFV9zC0qcuMTus+vlF3DLFM8RjPFXBVoW/A
         80aA==
X-Gm-Message-State: APjAAAUsYhPzczHuB82XtGqaeBqVBDrjT+OGNHOmZA2T350ofyZbc7mc
        6CkEXoYMKZsZUp8AfJ3vMB8=
X-Google-Smtp-Source: APXvYqwyFFb/4w3ky0siaqshpp366LIav0VnlYma8y80+MVjrW2dY7ouDbndARfIrS0U+5ILAfQejg==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr5620505wrs.303.1580392118099;
        Thu, 30 Jan 2020 05:48:38 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id o7sm6357958wmh.11.2020.01.30.05.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 05:48:37 -0800 (PST)
Date:   Thu, 30 Jan 2020 14:48:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] move_pages.2: Returning positive value is a new error
 case
Message-ID: <20200130134835.GW24244@dhcp22.suse.cz>
References: <1580334531-80354-1-git-send-email-yang.shi@linux.alibaba.com>
 <f276d8ec-b1be-4f8e-792b-5c3ca2de4714@suse.cz>
 <20200130120253.GU24244@dhcp22.suse.cz>
 <cce2e784-8092-00f5-32bf-d23ab7a53476@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce2e784-8092-00f5-32bf-d23ab7a53476@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 30-01-20 13:56:20, Vlastimil Babka wrote:
> On 1/30/20 1:02 PM, Michal Hocko wrote:
> > On Thu 30-01-20 10:06:28, Vlastimil Babka wrote:
> >> On 1/29/20 10:48 PM, Yang Shi wrote:
> >>> Since commit a49bd4d71637 ("mm, numa: rework do_pages_move"),
> >>> the semantic of move_pages() has changed to return the number of
> >>> non-migrated pages if they were result of a non-fatal reasons (usually a
> >>> busy page).  This was an unintentional change that hasn't been noticed
> >>> except for LTP tests which checked for the documented behavior.
> >>>
> >>> There are two ways to go around this change.  We can even get back to the
> >>> original behavior and return -EAGAIN whenever migrate_pages is not able
> >>
> >> The manpage says EBUSY, not EAGAIN? And should its description be
> >> updated too?
> > 
> > The idea was that we _could_ return EAGAIN from the syscall if
> > migrate_pages > 0.
> > 
> >> I.e. that it's no longer returned since 4.17?
> > 
> > I am pretty sure this will require a deeper consideration. Do we return
> > EIO/EINVAL?
> 
> I thought the manpage says we return -EBUSY, but I misread it, this part
> was not about errno, but the status array. So there's nothing to update
> there, sorry about the noise.
> 
> BTW, the suggestion to "Pre-initialization of the array to -1" means
> effectively it's pre-initialized to -EPERM. That's fine now as -EPERM is
> not one of the codes listed as possible to be returned via the array,
> but perhaps it's not entirely future-proof?

Hmm, I didn't realize EPERM is refering to 1. The wording however
suggests also any other value that cannot represent a valid NUMA node.
So maybe we should just drop the node about -1.
-- 
Michal Hocko
SUSE Labs
