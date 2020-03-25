Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B13192B72
	for <lists+linux-api@lfdr.de>; Wed, 25 Mar 2020 15:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCYOpB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Mar 2020 10:45:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43882 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgCYOpB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Mar 2020 10:45:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id b2so3399476wrj.10;
        Wed, 25 Mar 2020 07:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1wXJURRfaYTpe+TCjojzcV1WjXnlcA0INFVzjy7A9b0=;
        b=tSkb9VCEreIr/nKIM7duUF7EOQMl21u7RP0uKEr8YMkVhTaYvqPSaRT0DTYsoCDyT1
         4KS5/lLvquxwl6zAM/S+ed9rD+VDS3zzi7WF3yht/jrEc3EizSbeDQ6Hu8N6R1WWADSa
         NIzLUuy0Y4J2iVYFi3DUbAnTSjBEjIKACnVwOE9OeFmkbIysaegR45+ZmoqtWzYMTqyG
         d17DlkJY/CPsC4snROqtE+cNZvGkKMSC/iKjVbpaPHbt/TFOy7c7v6pyAJk7/zkuwdUs
         z7f+bpVfo6JZclm2F+ZcG2lUirSZw/vl0r5Ttcd0x7w/LOFoU0Pk2EnnxU0YoKjoM9R6
         RXiw==
X-Gm-Message-State: ANhLgQ2C1BFhMeDYMsUSn+gpkfu+T799sAXHCnBNMEzo2o6S0SPLuV3g
        847O6bcrM2u9JkhgoZPPow8=
X-Google-Smtp-Source: ADFU+vtP5TbgvM97466nU7Ig6JQ0PKYu5gHQ/U5ZR4td856KE9KuAti5Bf+113PwA58BsS0hnY0XFQ==
X-Received: by 2002:a5d:468c:: with SMTP id u12mr4074403wrq.394.1585147497291;
        Wed, 25 Mar 2020 07:44:57 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id b82sm9241480wmb.46.2020.03.25.07.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:44:56 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:44:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v2 2/2] kernel/sysctl: support handling command line aliases
Message-ID: <20200325144455.GE19542@dhcp22.suse.cz>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <20200325120345.12946-2-vbabka@suse.cz>
 <20200325142936.GC19542@dhcp22.suse.cz>
 <52faea3b-6442-3b1b-9404-6a018d1d1c44@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52faea3b-6442-3b1b-9404-6a018d1d1c44@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 25-03-20 15:36:23, Vlastimil Babka wrote:
> On 3/25/20 3:29 PM, Michal Hocko wrote:
> > Both patches look really great to me. I haven't really checked all the
> > details but from a quick glance they both seem ok.
> 
> Thanks.
> 
> > I would just add a small clarification here. Unless I am mistaken
> > early_param is called earlier than it would be now. But that shouldn't
> > cause any problems because the underlying implementation is just a noop
> > for backward compatibility.
> 
> Yeah, indeed worth noting somewhere explicitly. The conversion can't be done
> blindly, one has to consider whether the delay compared to early_param can be a
> disadvantage or not. For example the nmi_watchdog parameter is probably best
> left as it is?

I wouldn't mind moving nmi_watchdog timeout initialization to later. If
there is a usecase to rely on an early initialization then the patch can
be reverted but I struggle to think of anything reasonable. If the early
init code needs a lonter timeout to prevent from false positives then
there is clearly a bug to be better fixed. And a necessary shorter timeout
sounds quite exotic to me TBH.

-- 
Michal Hocko
SUSE Labs
