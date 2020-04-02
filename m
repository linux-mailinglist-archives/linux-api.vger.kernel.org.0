Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA219C384
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbgDBOBs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 10:01:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732434AbgDBOBr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 10:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585836106;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x06202PPsponxfSDbfvTzZWwYLXlP9C+BG2B0SFMxYo=;
        b=FAHfTZHy+iME/Jr0FgOHwqGRx38sxQDfevXvdN8aFtq1uobeWjeacIBODCx4C73jlyvVjG
        pL+r3Ot2O+RplbJjZE0LdxOZu3XQ2lxMhalhMTfL4QMVBn4FOzpnqnes5RX9kGTST/y6S2
        k+CxFPRMRAsCv1n1Pihjjj7FRefkIpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-72hyDqbUOuWMmr71FgHJ_g-1; Thu, 02 Apr 2020 10:01:42 -0400
X-MC-Unique: 72hyDqbUOuWMmr71FgHJ_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB0AB1084424;
        Thu,  2 Apr 2020 14:01:40 +0000 (UTC)
Received: from mchristi.msp.csb (ovpn-118-19.rdu2.redhat.com [10.10.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EA8960BF3;
        Thu,  2 Apr 2020 14:01:39 +0000 (UTC)
Reply-To: mchristi@redhat.com
Subject: Re: [PATCH] prctl.2: doc PR_SET/GET_IO_FLUSHER - V4
To:     Bart Van Assche <bvanassche@acm.org>, linux-api@vger.kernel.org,
        david@fromorbit.com, mhocko@suse.com, masato.suzuki@wdc.com,
        damien.lemoal@wdc.com, darrick.wong@oracle.com,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
References: <20200402020850.7218-1-mchristi@redhat.com>
 <9eab1b92-6a44-616a-44b2-f1ee6475f6f0@acm.org>
From:   Michael Christie <mchristi@redhat.com>
Organization: Red Hat
Message-ID: <c2451ffc-da39-9914-2d2e-e3a9a8356298@redhat.com>
Date:   Thu, 2 Apr 2020 09:01:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <9eab1b92-6a44-616a-44b2-f1ee6475f6f0@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 04/01/2020 10:46 PM, Bart Van Assche wrote:
> On 2020-04-01 19:08, Mike Christie wrote:
>> +.TP
>> +.B PR_GET_IO_FLUSHER (Since Linux 5.6)
>> +Return as the function result 1 if the caller is in the IO_FLUSHER st=
ate and
>> +0 if not.
>=20
> Although I'm not at all a language expert, the word order at the start
> of the above sentence seems a bit weird to me?
>=20

Do you mean the "Return as the function result" part or something else?

That is how the other commands worded it. It looks like I messed up and
dropped the (). This is how they did it:

"Return (as the function result)"

I will resend with that fix.

If I misunderstood you I will fix that too.




