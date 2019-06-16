Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD2047636
	for <lists+linux-api@lfdr.de>; Sun, 16 Jun 2019 19:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfFPRvQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 16 Jun 2019 13:51:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40199 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFPRvQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 16 Jun 2019 13:51:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so6740691wmj.5;
        Sun, 16 Jun 2019 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eVSTx+XKpmuAqrrVQWr/mEKYA3TUsuFexdVGwSEmrwY=;
        b=AHmV61cNcCytwE+8j8CjiMsjNIVOGRJl0x50kDtiUSH87Snpxrx+DQjlsrur1SfIqB
         //5heBapOMqdR6mE4KXvRhYF04XeAIcX5AX82SqojNUX3HwDn9QeOvHwrW5mCR/7W1v9
         lDgQz/gYNcGt9xJCn4Dn2pHQSSxDETDWn0BSbN/oEfVHIe/mrJGhS4ha3mXeF8YEEZnt
         8gMDj2Kp4huPCmhP7XjqhLIOm6PvSiZp/HgszoEmiRBNWTWi4B0otGGNvscDA8bKD/c4
         H7AUWqwpY8ZnIwojAii3StsNC/TP5Hy1JUcBtmvd1ARtIBSFoEHLkoraSPVMPciIaZus
         Y1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eVSTx+XKpmuAqrrVQWr/mEKYA3TUsuFexdVGwSEmrwY=;
        b=a6wK+b1JCiAmUgQVlIFTffnfv0l/3Fdoa4nCff/fyLvSq1kW3pE3160uAjZWd7JdxL
         FFNDsDvClJamIsS3NFO0ZdENZcRwEoeZxHDCAN32zXy1sxS1kDlIpp3qaOnkezKhLnsf
         DWkbEwYqdQkLSLQ/cs3NWumMRDWs7w3rCxS58/w/htVNyWI9E0CdaQazQnfr3Xfwv/oG
         qMzcSeLvUyfPVRUs//FjbNBj3SZh23zFd/pseuMoVGzBcqCE7WZgidtMWRDXkhxLt2sp
         Oywc1SL9Mb7nLVMFrXg3u2cqlS+ku80fRpKvpPSrRUs9PLzqrSk0kyIhZWjIh4A5SLW7
         NSNw==
X-Gm-Message-State: APjAAAWsXp9r92bSf5FildTGE9gNT5EwwPk4J7OTxgER2BGiNOdjAmiM
        /UqHlp8mObRWyeiSC/mImso=
X-Google-Smtp-Source: APXvYqyBF8D/KuFgdlt61asAqKXISiqUTVlj4ZuVudEgQCX1Wvy8FZxNRT73ct+SazvV623KepnaPw==
X-Received: by 2002:a1c:a807:: with SMTP id r7mr15250572wme.137.1560707474190;
        Sun, 16 Jun 2019 10:51:14 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12sm8502671wmh.34.2019.06.16.10.51.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 10:51:13 -0700 (PDT)
Subject: Re: [PATCHv4 17/28] x86/vdso: Switch image on
 setns()/unshare()/clone()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
References: <20190612192628.23797-1-dima@arista.com>
 <20190612192628.23797-18-dima@arista.com>
 <alpine.DEB.2.21.1906141603500.1722@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <efe0d911-e70d-c044-80fc-da7bab8e546d@gmail.com>
Date:   Sun, 16 Jun 2019 18:51:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906141603500.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/14/19 3:05 PM, Thomas Gleixner wrote:
> On Wed, 12 Jun 2019, Dmitry Safonov wrote:
>>  
>> +#ifdef CONFIG_TIME_NS
>> +int vdso_join_timens(struct task_struct *task)
>> +{
>> +	struct mm_struct *mm = task->mm;
>> +	struct vm_area_struct *vma;
>> +
>> +	if (down_write_killable(&mm->mmap_sem))
>> +		return -EINTR;
>> +
>> +	for (vma = mm->mmap; vma; vma = vma->vm_next) {
>> +		unsigned long size = vma->vm_end - vma->vm_start;
>> +
>> +		if (vma_is_special_mapping(vma, &vvar_mapping) ||
>> +		    vma_is_special_mapping(vma, &vdso_mapping))
>> +			zap_page_range(vma, vma->vm_start, size);
>> +	}
>> +
>> +	up_write(&mm->mmap_sem);
>> +	return 0;
>> +}
>> +#else /* CONFIG_TIME_NS */
>> +int vdso_join_timens(struct task_struct *task)
>> +{
>> +	return -ENXIO;
>> +}
> 
> Is that else path really required? The callsite is only compiled when
> CONFIG_TIME_NS is enabled, right?

Oh, yes - will drop this.

Thanks,
          Dmitry
